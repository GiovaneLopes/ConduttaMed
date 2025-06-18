import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:condutta_med/libs/acls/models/acls_step.dart';
import 'package:condutta_med/libs/acls/models/acls_alert.dart';
import 'package:condutta_med/libs/acls/models/activity_log.dart';
import 'package:condutta_med/modules/shared/utils/vibrator.dart';
import 'package:condutta_med/modules/shared/utils/nullable.dart';
import 'package:condutta_med/libs/src/exceptions/app_error.dart';
import 'package:condutta_med/libs/acls/models/acls_settings.dart';
import 'package:condutta_med/modules/shared/resources/audios.dart';
import 'package:condutta_med/libs/acls/models/acls_medications.dart';
import 'package:condutta_med/libs/acls/models/acls_history_item.dart';
import 'package:condutta_med/libs/acls/models/acls_heart_frequency.dart';
import 'package:condutta_med/modules/acls/bloc/acls_history/acls_history_cubit.dart';
import 'package:condutta_med/modules/acls/bloc/acls_settings/acls_settings_cubit.dart';

part 'acls_state.dart';

enum AclsStatus {
  initial,
  loading,
  loaded,
  error,
}

class AclsCubit extends Cubit<AclsState> {
  final AclsSettingsCubit settingsCubit;
  final AclsHistoryCubit historyCubit;
  final AudioPlayer _player = AudioPlayer();
  Timer? _totalTimer;
  Timer? _compressionsTimer;
  Timer? _compressionsRestTimer;
  Timer? _adrenalineTimer;
  Timer? _metronomeTimer;

  AclsCubit(this.settingsCubit, this.historyCubit) : super(const AclsState());

  void initTimer() async {
    emit(state.copyWith(
        settings: settingsCubit.state.settings, srtartTime: DateTime.now()));
    _updateActivities('Início da RCP');
    _totalTimer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        emit(state.copyWith(totalTimer: timer));
      },
    );
  }

  Future<void> startCompressions() async {
    _startMetronome();
    emit(state.copyWith(
      compressionsTimer: () => Timer(const Duration(seconds: 1), () {}),
      totalCompressions: state.totalCompressions + 1,
      step: state.heartFrequency == AclsHeartFrequency.unknown
          ? AclsStep.frequency
          : state.heartFrequency.isShockable
              ? AclsStep.shock
              : AclsStep.medication,
    ));
    _compressionsTimer =
        Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (timer.tick <= state.compressionsTotalTime) {
        emit(state.copyWith(compressionsTimer: () => timer));
        if (state.compressionsTimeLeft == 30) {
          Vibrator.vibrate();
          _showSnackBar(AclsAlert.prepararTrocaDeSocorrista);
        } else if (state.compressionsTimeLeft == 15) {
          Vibrator.vibrate();
          _showSnackBar(AclsAlert.prepararChecagemRitmoEPulso);
        }
      } else {
        stopCompressions();
      }
      emit(state.copyWith(
          totalCompressionsTime: state.totalCompressionsTime + 1));
    });
    _updateActivities(
        'Início: Ciclo de compressões ${state.totalCompressions}');
  }

  Future<void> stopCompressions() async {
    _startRest();
    _compressionsTimer?.cancel();
    _metronomeTimer?.cancel();
    Vibrator.vibrate();
    _showSnackBar(AclsAlert.checarRitmoEPulso);
    _updateActivities('Fim: Ciclo de compressões ${state.totalCompressions}');
    await Future.delayed(const Duration(seconds: 10));
    if (state.compressionsTimer?.isActive == false) {
      _showSnackBar(AclsAlert.tempoEntreCompressoes);
      emit(state.copyWith(step: AclsStep.massage));
    }
  }

  Future<void> _startMetronome() async {
    _metronomeTimer = Timer.periodic(
      Duration(milliseconds: state.settings.miliseconds),
      (timer) async {
        await _player.setAsset(Audios.metronome);
        await _player.play();
      },
    );
  }

  Future<void> _startRest() async {
    _compressionsRestTimer?.cancel();
    emit(state.copyWith(
        restTimer: () => Timer(const Duration(seconds: 1), () {})));
    _compressionsRestTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (timer.tick < state.restTotalTime) {
          emit(state.copyWith(restTimer: () => timer));
        } else {
          _compressionsRestTimer?.cancel();
        }
      },
    );
  }

  Future<void> startAdrenaline() async {
    if (state.compressionsTimer?.isActive ?? false) {
      _adrenalineTimer?.cancel();
      emit(state.copyWith(
        totalAdrenalines: state.totalAdrenalines + 1,
        totalMedications: state.totalMedications + 1,
      ));
      _updateActivities('Adrenalina ${state.totalAdrenalines}');
      emit(state.copyWith(
          medicationTimer: () => Timer(const Duration(seconds: 1), () {})));
      _adrenalineTimer =
          Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (timer.tick <= state.medicationTotalTime) {
          emit(state.copyWith(medicationTimer: () => timer));
        } else {
          _showSnackBar(AclsAlert.medicacaoRecomendada);
          _adrenalineTimer?.cancel();
        }
      });
    } else {
      _showSnackBar(AclsAlert.medicacaoSemMassagem);
    }
  }

  Future<void> startShock() async {
    emit(state.copyWith(totalShocks: state.totalShocks + 1));
    _showSnackBar(AclsAlert.choqueAdicionado);
    stopCompressions();
    _updateActivities('Choque ${state.totalShocks}');
  }

  void selectFrequency(AclsHeartFrequency frequency) async {
    emit(state.copyWith(heartFrequency: frequency));
    if (frequency == AclsHeartFrequency.assistolia) {
      _showSnackBar(AclsAlert.checarCAGADA);
    }
    if (state.compressionsTimer?.isActive == false) {
      emit(state.copyWith(step: AclsStep.massage));
    } else if (state.heartFrequency.isShockable) {
      emit(state.copyWith(step: AclsStep.shock));
    } else {
      emit(state.copyWith(step: AclsStep.medication));
    }
    _updateActivities(frequency.toString());
  }

  void addMedication(AclsMedication medication) {
    emit(state.copyWith(
      medications: [...state.medications, medication],
      totalMedications: state.totalMedications + 1,
    ));
    _showSnackBar(AclsAlert.outraMedicacaoAdicionada);
    _updateActivities(medication.name);
    Vibrator.vibrate();
  }

  void addEvent(String event) {
    emit(state.copyWith(events: [...state.events, event]));
    _showSnackBar(AclsAlert.eventoAdicionado);
    _updateActivities(event);
    Vibrator.vibrate();
  }

  void advancedAirwayChanged() {
    emit(state.copyWith(advancedAirway: !state.advancedAirway));
    if (state.advancedAirway) {
      _showSnackBar(AclsAlert.viaAeraAvancadaDisponivelACLS);
      Vibrator.vibrate();
    }
    _updateActivities(
        'Via aérea Avançada ${state.advancedAirway ? 'Disponível' : 'Indisponível'}');
  }

  void _updateActivities(String activity) {
    emit(state.copyWith(
      activities: [
        ...state.activities,
        ActivityLog(
          state.totalTimeFormatted,
          activity,
        )
      ],
    ));
  }

  void _showSnackBar(AclsAlert alert) {
    emit(state.copyWith(alert: () => alert));
    emit(state.copyWith(alert: () => null));
  }

  void finishRCP() {
    _totalTimer?.cancel();
    _compressionsTimer?.cancel();
    _compressionsRestTimer?.cancel();
    _adrenalineTimer?.cancel();
    _metronomeTimer?.cancel();
    historyCubit.saveHistory(
      AclsHistoryItem(
        id: DateTime.now().toIso8601String(),
        date: state.srtartTime ?? DateTime.now(),
        totalCompressions: state.totalCompressions,
        totalShocks: state.totalShocks,
        totalAdrenalines: state.totalAdrenalines,
        totalMedications: state.totalMedications,
        activities: state.activities,
        duration: state.totalTimerTick,
        fct: state.fct,
        totalCompressionsTime: state.totalCompressionsTime,
      ),
    );
    _updateActivities('Fim da RCP');
    emit(const AclsState());
  }
}
