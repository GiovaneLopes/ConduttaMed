import 'package:firebase_auth/firebase_auth.dart';
import 'package:condutta_med/libs/user/model/user_model.dart';
import 'package:condutta_med/libs/user/datasource/user_datasource.dart';

abstract class UserRepository {
  Future<void> register(UserModel user);
  Future<UserCredential> googleAuthentication();
  Future<UserCredential> appleRegister();
  Future<void> update(UserModel user);
  Future<void> saveUserData(UserModel user);
  Future<User> login(String email, String password);
  Future<UserModel?> getUser();
  Future<bool?> verifyEmail();
  Future<void> sendEmailConfirmation();
  Future<void> recoverPassword(String email);
  Future<void> logout();
}

class UserRepositoryImpl extends UserRepository {
  final UserDatasource datasource;

  UserRepositoryImpl(this.datasource);
  @override
  Future<void> register(UserModel user) async {
    await datasource.register(user);
  }

  @override
  Future<void> update(UserModel user) async {
    await datasource.update(user);
  }

  @override
  Future<void> saveUserData(UserModel user) async {
    await datasource.saveUserData(user);
  }

  @override
  Future<User> login(String email, String password) async {
    return await datasource.login(email, password);
  }

  @override
  Future<UserModel?> getUser() async {
    return await datasource.getUser();
  }

  @override
  Future<bool?> verifyEmail() async {
    return await datasource.verifyEmail();
  }

  @override
  Future<void> sendEmailConfirmation() async {
    return await datasource.sendEmailConfirmation();
  }

  @override
  Future<void> recoverPassword(String email) async {
    return await datasource.recoverPassword(email);
  }

  @override
  Future<void> logout() async {
    return await datasource.logout();
  }

  @override
  Future<UserCredential> appleRegister() async {
    return await datasource.appleRegister();
  }

  @override
  Future<UserCredential> googleAuthentication() async {
    return await datasource.googleAuthentication();
  }
}
