import '../model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:condutta_med/libs/src/utils/network_checker.dart';
import 'package:condutta_med/libs/src/exceptions/generic_errors.dart';
import 'package:condutta_med/libs/user/errors/user_datasource_errors.dart';

abstract class UserDatasource {
  Future<void> register(UserModel newUser);
  Future<User> login(String email, String password);
  Future<UserModel?> getUser();
  Future<bool> verifyEmail();
  Future<void> sendEmailConfirmation();
  Future<void> recoverPassword(String email);
  Future<void> logout();
}

class UserDatasourceImpl extends UserDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _db = FirebaseDatabase.instance;

  Future<T> _safeCall<T>(Future<T> Function() action) async {
    try {
      await NetworkChecker.checkConnection();

      return await action();
    } on FirebaseAuthException catch (e) {
      throw UserDatasourceError.fromFirebaseAuthException(e);
    } catch (e) {
      if (e is AppGenericErrors) {
        if (e.code == AppGenericErrors.noConnectionError.code) {
          throw AppGenericErrors.noConnectionError;
        }
      }
      throw AppGenericErrors.genericError;
    }
  }

  @override
  Future<void> register(UserModel newUser) async {
    await _safeCall(() async {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: newUser.email ?? '',
        password: newUser.password ?? '',
      );
      final User? user = userCredential.user;

      if (user != null) {
        final usersRef = _db.ref('users/').child(user.uid);
        await usersRef.set(newUser.toJson());
        await user.sendEmailVerification();
      } else {
        throw FirebaseAuthException;
      }
    });
  }

  @override
  Future<UserModel?> getUser() async {
    return await _safeCall(() async {
      final uid = _auth.currentUser?.uid;

      if (uid != null) {
        final usersRef = _db.ref('users/').child(uid);
        final response = await usersRef.get();
        final userData = Map<String, dynamic>.from(response.value as Map);
        final user = UserModel.fromJson(userData);
        return user.copyWith(id: uid);
      } else {
        return null;
      }
    });
  }

  @override
  Future<bool> verifyEmail() async {
    return await _safeCall(() async {
      await _auth.currentUser?.reload();
      final user = _auth.currentUser;
      return user?.emailVerified ?? false;
    });
  }

  @override
  Future<void> sendEmailConfirmation() async {
    await _safeCall(() async {
      await _auth.currentUser?.sendEmailVerification();
    });
  }

  @override
  Future<User> login(String email, String password) async {
    return await _safeCall(() async {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        return userCredential.user!;
      } else {
        throw Exception();
      }
    });
  }

  @override
  Future<void> recoverPassword(String email) async {
    await _safeCall(() async {
      await _auth.sendPasswordResetEmail(email: email);
    });
  }

  @override
  Future<void> logout() async {
    await _safeCall(() async {
      await _auth.signOut();
    });
  }
}
