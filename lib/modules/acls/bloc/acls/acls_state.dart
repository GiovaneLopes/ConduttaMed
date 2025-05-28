part of 'acls_cubit.dart';

class AclsState {
  final AclsSettings settings;
  final AclsStatus status;
  final AclsStep step;
  final Timer? totalTimer;
  final int compressionsTime;
  final int adrenalineTime;
  final AclsHeartFrequency heartFrequency;
  final List<String> events;
  final List<AclsMedication> medications;
  final bool advancedAirway;
  final AclsAlert? alert;
  final AppError? error;

  const AclsState({
    this.settings = const AclsSettings(),
    this.status = AclsStatus.initial,
    this.step = AclsStep.massage,
    this.totalTimer,
    this.compressionsTime = 120,
    this.adrenalineTime = 240,
    this.heartFrequency = AclsHeartFrequency.unknown,
    this.events = const [],
    this.medications = const [],
    this.advancedAirway = false,
    this.alert,
    this.error,
  });
  String formatTime(int? sec) {
    if (sec == null) {
      return '00:00';
    }
    final minutes = sec ~/ 60;
    final seconds = sec % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  AclsState copyWith({
    AclsSettings? settings,
    AclsStatus? status,
    AclsStep? step,
    Timer? totalTimer,
    int? compressionsTime,
    int? adrenalineTime,
    AclsHeartFrequency? heartFrequency,
    List<String>? events,
    List<AclsMedication>? medications,
    bool? advancedAirway,
    AclsAlert? Function()? alert,
    AppError? error,
  }) {
    return AclsState(
      settings: settings ?? this.settings,
      status: status ?? this.status,
      step: step ?? this.step,
      totalTimer: totalTimer ?? this.totalTimer,
      compressionsTime: compressionsTime ?? this.compressionsTime,
      adrenalineTime: adrenalineTime ?? this.adrenalineTime,
      heartFrequency: heartFrequency ?? this.heartFrequency,
      events: events ?? this.events,
      medications: medications ?? this.medications,
      advancedAirway: advancedAirway ?? this.advancedAirway,
      alert: alert != null ? alert() : this.alert,
      error: error ?? this.error,
    );
  }
}
