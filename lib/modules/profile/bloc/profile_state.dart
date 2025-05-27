part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserModel? user;
  final AppError? error;
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.user,
    this.error,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    UserModel? Function()? user,
    AppError? error,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user != null ? user() : this.user,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        user,
        error,
      ];
}
