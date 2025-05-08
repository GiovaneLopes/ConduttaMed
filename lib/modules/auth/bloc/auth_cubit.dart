import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:condutta_med/modules/home/home_routes.dart';
import 'package:condutta_med/modules/auth/auth_routes.dart';
import 'package:condutta_med/libs/user/model/user_model.dart';
import 'package:condutta_med/libs/src/exceptions/app_error.dart';
import 'package:condutta_med/modules/shared/utils/app_route.dart';
import 'package:condutta_med/libs/user/repository/user_repository.dart';
import 'package:condutta_med/libs/user/errors/user_datasource_errors.dart';

part 'auth_state.dart';

enum AuthStatus {
  uninitialized,
  loading,
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
      final user = await repository.getUser();
      emit(state.copyWith(
        user: () => user,
        status: AuthStatus.loaded,
      ));
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

  Future<void> login(String email, String passsword) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      final response = await repository.login(email, passsword);
      if (response.emailVerified) {
        final user = await repository.getUser();
        emit(state.copyWith(
          route: HomeRoutes.home,
          status: AuthStatus.loaded,
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
      if (isVerified) {
        final user = await repository.getUser();
        emit(state.copyWith(
          status: AuthStatus.loaded,
          user: () => user,
          route: HomeRoutes.home,
        ));
      } else {
        throw UserDatasourceError.emailNotVerified;
      }
      emit(state.copyWith(status: AuthStatus.loaded));
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
      throw UserDatasourceError(
        title: 'E-mail enviado',
        message: 'Enviamos um novo link de confirmação para seu e-mail',
      );
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
      final user = await repository.getUser();
      emit(state.copyWith(
        status: AuthStatus.loaded,
        user: () => user,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStatus.error,
        error: e as AppError,
      ));
    }
  }
}
