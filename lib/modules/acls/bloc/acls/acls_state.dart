part of 'acls_cubit.dart';

class AclsState {
  final AclsSettings settings;
  final AclsStatus status;
  final Timer? totalTimer;
  final AclsHeartFrequency heartFrequency;
  final List<String> events;
  final List<AclsMedication> medications;
  final bool advancedAirway;
  final AclsAlert? alert;
  final AppError? error;

  const AclsState({
    this.settings = const AclsSettings(),
    this.status = AclsStatus.initial,
    this.totalTimer,
    this.heartFrequency = AclsHeartFrequency.unknown,
    this.events = const [],
    this.medications = const [],
    this.advancedAirway = false,
    this.alert,
    this.error,
  });

  String formatTime(Timer? timer) {
    if (timer == null) {
      return '00:00';
    }
    final minutes = timer.tick ~/ 60;
    final seconds = timer.tick % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  AclsState copyWith({
    AclsSettings? settings,
    AclsStatus? status,
    Timer? totalTimer,
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
      totalTimer: totalTimer ?? this.totalTimer,
      heartFrequency: heartFrequency ?? this.heartFrequency,
      events: events ?? this.events,
      medications: medications ?? this.medications,
      advancedAirway: advancedAirway ?? this.advancedAirway,
      alert: alert != null ? alert() : this.alert,
      error: error ?? this.error,
    );
  }
}
