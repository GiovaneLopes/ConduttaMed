import '../model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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

  @override
  Future<void> register(UserModel newUser) async {
    try {
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
    } on FirebaseAuthException catch (e) {
      throw UserDatasourceError.fromFirebaseAuthException(e);
    } catch (e) {
      throw AppGenericErrors.genericError;
    }
  }

  @override
  Future<UserModel?> getUser() async {
    try {
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
    } catch (e) {
      throw AppGenericErrors.genericError;
    }
  }

  @override
  Future<bool> verifyEmail() async {
    try {
      await _auth.currentUser?.reload();
      final user = _auth.currentUser;

      if (user?.emailVerified ?? false) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw AppGenericErrors.genericError;
    }
  }

  @override
  Future<void> sendEmailConfirmation() async {
    await _auth.currentUser?.sendEmailVerification();
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        return userCredential.user!;
      } else {
        throw Exception();
      }
    } on FirebaseAuthException catch (e) {
      throw UserDatasourceError.fromFirebaseAuthException(e);
    } catch (e) {
      throw AppGenericErrors.genericError;
    }
  }

  @override
  Future<void> recoverPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw AppGenericErrors.genericError;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw UserDatasourceError.fromFirebaseAuthException(e);
    } catch (e) {
      throw AppGenericErrors.genericError;
    }
  }
}
