import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/home/home_routes.dart';
import 'package:condutta_med/modules/auth/auth_routes.dart';
import 'package:condutta_med/libs/user/model/user_model.dart';
import 'package:condutta_med/libs/src/exceptions/app_error.dart';
import 'package:condutta_med/modules/shared/utils/app_route.dart';
import 'package:condutta_med/libs/user/repository/user_repository.dart';
import 'package:condutta_med/libs/user/errors/user_datasource_errors.dart';

part 'auth_state.dart';

enum AuthStatus {
  initial,
  loading,
  authenticating,
  authenticated,
  loaded,
  error,
}

class AuthCubit extends Cubit<AuthState> {
  final UserRepository repository;
  AuthCubit(this.repository) : super(const AuthState()) {
    initialize();
  }

  Future<void> initialize() async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      final isVerified = await repository.verifyEmail();
      if (isVerified != null && isVerified == false) {
        emit(state.copyWith(route: AuthRoutes.emailConfirmation));
      } else {
        final user = await repository.getUser();
        await Future.delayed(const Duration(seconds: 3));
        emit(state.copyWith(
          user: () => user,
          route: HomeRoutes.home,
        ));
      }
      emit(state.copyWith(status: AuthStatus.loaded));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        error: e as AppError,
      ));
    }
  }

  Future<void> register(UserModel user) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      await repository.register(user);
      emit(state.copyWith(
        status: AuthStatus.loaded,
        route: AuthRoutes.emailConfirmation,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        error: e as AppError,
      ));
    }
  }

  Future<void> googleAuthentication() async {
    try {
      emit(state.copyWith(status: AuthStatus.authenticating));
      final auth = await repository.googleAuthentication();
      final user = await repository.getUser();
      if (user != null) {
        emit(state.copyWith(
          user: () => user,
          status: AuthStatus.authenticated,
        ));
      } else {
        emit(state.copyWith(
          status: AuthStatus.loaded,
          route: AuthRoutes.registration,
          user: () => UserModel(
            id: auth.user?.uid,
            name: auth.user?.displayName,
            email: auth.user?.email,
          ),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        error: e as AppError,
      ));
    }
  }

  Future<void> appleRegister() async {
    try {
      final auth = await repository.appleRegister();
      final user = await repository.getUser();
      if (user != null) {
        emit(state.copyWith(
          user: () => user,
          status: AuthStatus.authenticated,
        ));
      } else {
        emit(state.copyWith(
          status: AuthStatus.loaded,
          route: AuthRoutes.registration,
          user: () => UserModel(
            id: auth.user?.uid,
            name: auth.user?.displayName,
            email: auth.user?.email,
          ),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        error: e as AppError,
      ));
    }
  }

  Future<void> saveUserData(UserModel newUser) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      await repository.saveUserData(newUser);
      emit(state.copyWith(
        status: AuthStatus.loaded,
        user: () => newUser,
      ));
      Modular.to.pop();
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        error: e as AppError,
      ));
    }
  }

  Future<void> login(String email, String password) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      final response = await repository.login(email, password);
      if (response.emailVerified) {
        final user = await repository.getUser();
        emit(state.copyWith(
          route: HomeRoutes.home,
          status: AuthStatus.authenticated,
          user: () => user,
        ));
      } else {
        emit(state.copyWith(
          route: AuthRoutes.emailConfirmation,
          status: AuthStatus.loaded,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        error: e as AppError,
      ));
    }
  }

  Future<void> verifyEmail() async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      final isVerified = await repository.verifyEmail();
      if (isVerified == true) {
        emit(state.copyWith(route: HomeRoutes.home));
        await Future.delayed(const Duration(milliseconds: 250));
        initialize();
      } else {
        emit(state.copyWith(
          status: AuthStatus.error,
          error: UserDatasourceError.emailNotVerified,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        error: e as AppError,
      ));
    }
  }

  Future<void> sendConfirmationEmail() async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      await repository.sendEmailConfirmation();
      emit(state.copyWith(status: AuthStatus.loaded));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        error: e as AppError,
      ));
    }
  }

  Future<void> recoverPassword(String email) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      await repository.recoverPassword(email);
      emit(state.copyWith(status: AuthStatus.loaded));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        error: e as AppError,
      ));
    }
  }

  Future<void> logout() async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      await repository.logout();

      emit(state.copyWith(
        status: AuthStatus.loaded,
        user: () => null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        error: e as AppError,
      ));
    }
  }
}
