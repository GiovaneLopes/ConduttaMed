part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final AppRoute? route;
  final AuthStatus status;
  final UserModel? user;
  final AppError? error;

  const AuthState({
    this.route,
    this.status = AuthStatus.uninitialized,
    this.user,
    this.error,
  });

  AuthState copyWith({
    AppRoute? route,
    AuthStatus? status,
    UserModel? Function()? user,
    AppError? error,
  }) {
    return AuthState(
      route: route?..navigate(),
      status: status ?? this.status,
      user: user != null ? user() : this.user,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        route,
        status,
        user,
        error,
      ];
}
