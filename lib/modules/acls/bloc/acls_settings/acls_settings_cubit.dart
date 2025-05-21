import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:condutta_med/modules/auth/bloc/auth_cubit.dart';
import 'package:condutta_med/libs/src/exceptions/app_error.dart';
import 'package:condutta_med/libs/acls/models/acls_settings.dart';
import 'package:condutta_med/libs/src/exceptions/generic_errors.dart';
import 'package:condutta_med/libs/acls/repository/acls_repository.dart';

part 'acls_settings_state.dart';

enum AclsSettingsStatus {
  uninitialized,
  loading,
  loaded,
  error,
}

class AclsSettingsCubit extends Cubit<AclsSettingsState> {
  final AclsRespositoryImpl _repository;
  final AuthCubit _authCubit;
  AclsSettingsCubit(
    this._authCubit,
    this._repository,
  ) : super(const AclsSettingsState()) {
    initialize();
  }

  Future<void> initialize() async {
    try {
      emit(state.copyWith(status: AclsSettingsStatus.loading));
      final settings =
          await _repository.loadSettings(_authCubit.state.user?.id);
      if (settings != null) {
        emit(state.copyWith(settings: settings));
      }
      emit(state.copyWith(status: AclsSettingsStatus.loaded));
    } catch (e) {
      emit(state.copyWith(
        status: AclsSettingsStatus.error,
        error: AppGenericErrors.genericError,
      ));
    }
  }

  Future<void> updateSettings(AclsSettings settings) async {
    try {
      await _repository.saveSettings(settings, _authCubit.state.user?.id);
      emit(state.copyWith(settings: settings));
    } catch (e) {
      emit(state.copyWith(
        status: AclsSettingsStatus.error,
        error: AppGenericErrors.genericError,
      ));
    }
  }

  Future<void> resetSettings() async {
    try {
      await _repository.resetSettings(_authCubit.state.user?.id);
      emit(state.copyWith(settings: const AclsSettings()));
    } catch (e) {
      emit(state.copyWith(
        status: AclsSettingsStatus.error,
        error: AppGenericErrors.genericError,
      ));
    }
  }
}
