import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:condutta_med/libs/user/model/user_model.dart';
import 'package:condutta_med/libs/src/exceptions/app_error.dart';
import 'package:condutta_med/libs/user/repository/user_repository.dart';

part 'profile_state.dart';

enum ProfileStatus {
  initial,
  loading,
  loaded,
  updated,
  error,
}

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository repository;
  ProfileCubit(this.repository) : super(const ProfileState()) {
    initialize();
  }

  void initialize() async {
    try {
      emit(state.copyWith(status: ProfileStatus.loading));
      final user = await repository.getUser();
      emit(state.copyWith(
        status: ProfileStatus.loaded,
        user: () => user,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        error: e as AppError,
      ));
    }
  }

  void update(UserModel user) async {
    try {
      emit(state.copyWith(status: ProfileStatus.loading));
      await repository.update(user);
      emit(state.copyWith(status: ProfileStatus.updated));
      initialize();
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        error: e as AppError,
      ));
    }
  }
}
