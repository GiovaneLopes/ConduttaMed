part of 'acls_cubit.dart';

class AclsState {
  final AclsSettings settings;
  final AclsStatus status;
  final AclsStep step;
  final DateTime? srtartTime;
  final Timer? totalTimer;
  final Timer? compressionsTimer;
  final Timer? restTimer;
  final Timer? medicationTimer;
  final AclsHeartFrequency heartFrequency;
  final List<String> events;
  final List<AclsMedication> medications;
  final bool advancedAirway;
  final int totalCompressions;
  final int totalAdrenalines;
  final int totalMedications;
  final int totalShocks;
  final int totalCompressionsTime;
  final List<ActivityLog> activities;
  final AclsAlert? alert;
  final AppError? error;

  const AclsState({
    this.settings = const AclsSettings(),
    this.status = AclsStatus.initial,
    this.step = AclsStep.massage,
    this.srtartTime,
    this.totalTimer,
    this.compressionsTimer,
    this.restTimer,
    this.medicationTimer,
    this.heartFrequency = AclsHeartFrequency.unknown,
    this.events = const [],
    this.medications = const [],
    this.advancedAirway = false,
    this.totalCompressions = 0,
    this.totalAdrenalines = 0,
    this.totalMedications = 0,
    this.totalShocks = 0,
    this.totalCompressionsTime = 0,
    this.activities = const [],
    this.alert,
    this.error,
  });

  String formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String get compressionsTimerFormatted {
    bool isTimer1Active = compressionsTimer?.isActive ?? false;
    bool isTimer2Active = restTimer?.isActive ?? false;

    if (!isTimer1Active && !isTimer2Active) {
      return formatTime(compressionsTotalTime);
    } else if (isTimer1Active) {
      return formatTime(compressionsTimeLeft);
    } else {
      return formatTime(restTimeLeft);
    }
  }

  int get totalTimerTick => totalTimer?.tick ?? 0;
  String get totalTimeFormatted => formatTime(totalTimer?.tick ?? 0);

  int get compressionsTotalTime => 120;
  int get restTotalTime => 10;
  int get medicationTotalTime => settings.defaultTime * 60;

  int get compressionsTick => compressionsTimer?.tick ?? 0;
  int get compressionsTimeLeft => compressionsTotalTime - compressionsTick;

  int get restTick => restTimer?.tick ?? 0;
  int get restTimeLeft => restTotalTime - restTick;

  int get medicationTick => medicationTimer?.tick ?? 0;
  int get medicationTimeLeft => (medicationTotalTime - medicationTick) >= 0
      ? (medicationTotalTime - medicationTick)
      : medicationTotalTime;

  int get fct => totalTimerTick != 0
      ? ((totalCompressionsTime / totalTimerTick) * 100).toInt()
      : 0;
  AclsState copyWith({
    AclsSettings? settings,
    AclsStatus? status,
    AclsStep? step,
    DateTime? srtartTime,
    Timer? totalTimer,
    Nullable<Timer?>? compressionsTimer,
    Nullable<Timer?>? restTimer,
    Nullable<Timer?>? medicationTimer,
    AclsHeartFrequency? heartFrequency,
    List<String>? events,
    List<AclsMedication>? medications,
    bool? advancedAirway,
    int? totalCompressions,
    int? totalAdrenalines,
    int? totalMedications,
    int? totalShocks,
    int? totalCompressionsTime,
    List<ActivityLog>? activities,
    AclsAlert? Function()? alert,
    AppError? error,
  }) {
    return AclsState(
      settings: settings ?? this.settings,
      status: status ?? this.status,
      step: step ?? this.step,
      srtartTime: srtartTime ?? this.srtartTime,
      totalTimer: totalTimer ?? this.totalTimer,
      compressionsTimer: compressionsTimer != null
          ? compressionsTimer()
          : this.compressionsTimer,
      restTimer: restTimer != null ? restTimer() : this.restTimer,
      medicationTimer:
          medicationTimer != null ? medicationTimer() : this.medicationTimer,
      heartFrequency: heartFrequency ?? this.heartFrequency,
      events: events ?? this.events,
      medications: medications ?? this.medications,
      advancedAirway: advancedAirway ?? this.advancedAirway,
      totalCompressions: totalCompressions ?? this.totalCompressions,
      totalAdrenalines: totalAdrenalines ?? this.totalAdrenalines,
      totalShocks: totalShocks ?? this.totalShocks,
      totalMedications: totalMedications ?? this.totalMedications,
      totalCompressionsTime:
          totalCompressionsTime ?? this.totalCompressionsTime,
      activities: activities ?? this.activities,
      alert: alert != null ? alert() : this.alert,
      error: error ?? this.error,
    );
  }
}
