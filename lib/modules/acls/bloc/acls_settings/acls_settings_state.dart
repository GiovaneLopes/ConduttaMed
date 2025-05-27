part of 'acls_settings_cubit.dart';

class AclsSettingsState {
  final AclsSettingsStatus status;
  final AppError? error;
  final AclsSettings settings;

  const AclsSettingsState({
    this.status = AclsSettingsStatus.initial,
    this.error,
    this.settings = const AclsSettings(),
  });

  List<int> get frequencies => [100, 105, 110, 115, 120];
  List<int> get times => [3, 4, 5];

  AclsSettingsState copyWith({
    AclsSettingsStatus? status,
    AppError? error,
    AclsSettings? settings,
  }) {
    return AclsSettingsState(
      status: status ?? this.status,
      error: error ?? this.error,
      settings: settings ?? this.settings,
    );
  }
}
