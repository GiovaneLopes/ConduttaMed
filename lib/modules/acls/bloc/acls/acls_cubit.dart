import 'dart:async';
import 'package:condutta_med/libs/acls/models/acls_step.dart';
import 'package:condutta_med/modules/shared/resources/audios.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:condutta_med/libs/acls/models/acls_alert.dart';
import 'package:condutta_med/libs/src/exceptions/app_error.dart';
import 'package:condutta_med/libs/acls/models/acls_settings.dart';
import 'package:condutta_med/libs/acls/models/acls_medications.dart';
import 'package:condutta_med/libs/acls/models/acls_heart_frequency.dart';
import 'package:condutta_med/modules/acls/bloc/acls_settings/acls_settings_cubit.dart';
import 'package:just_audio/just_audio.dart';

part 'acls_state.dart';

enum AclsStatus {
  initial,
  loading,
  loaded,
  error,
}

class AclsCubit extends Cubit<AclsState> {
  final AclsSettingsCubit settingsCubit;
  late AudioPlayer _player;
  Timer? _compressionsTimer;
  Timer? _adrenalineTimer;
  Timer? _metronomeTimer;
  AclsCubit(this.settingsCubit) : super(const AclsState()) {
    _player = AudioPlayer();
    settingsCubit.stream.listen((settingsState) {
      emit(state.copyWith(settings: settingsState.settings));
    });
    initTimer();
  }

  void initTimer() async {
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        emit(state.copyWith(totalTimer: timer));
      },
    );
  }

  Future<void> startCompressions() async {
    if (_compressionsTimer?.isActive ?? false) {
      _compressionsTimer?.cancel();
      _metronomeTimer?.cancel();
      emit(state.copyWith(compressionsTime: 120));
      showSnackBar(AclsAlert.checarRitmoEPulso);
    } else {
      emit(state.copyWith(
        compressionsTime: state.compressionsTime - 1,
        step: state.heartFrequency.isShockable
            ? AclsStep.medication
            : AclsStep.shock,
      ));
      _metronomeTimer = Timer.periodic(
        Duration(milliseconds: state.settings.miliseconds),
        (timer) async => playSound(),
      );
      _compressionsTimer =
          Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (state.compressionsTime > 0) {
          emit(state.copyWith(compressionsTime: state.compressionsTime - 1));
          if (state.compressionsTime == 30) {
            showSnackBar(AclsAlert.prepararTrocaDeSocorrista);
          } else if (state.compressionsTime == 15) {
            showSnackBar(AclsAlert.prepararChecagemRitmoEPulso);
          }
        } else {
          _compressionsTimer?.cancel();
          _metronomeTimer?.cancel();
          emit(state.copyWith(compressionsTime: 120));
          showSnackBar(AclsAlert.checarRitmoEPulso);
          await Future.delayed(const Duration(seconds: 10));
          emit(state.copyWith(step: AclsStep.massage));
          showSnackBar(AclsAlert.tempoEntreCompressoes);
        }
      });
    }
  }

  Future<void> startMedication() async {
    if (_adrenalineTimer?.isActive ?? false) {
      // _adrenalineTimer?.cancel();
      // emit(state.copyWith(adrenalineTime: 240));
      // showSnackBar(AclsAlert.checarRitmoEPulso);
    } else {
      emit(state.copyWith(adrenalineTime: state.adrenalineTime - 1));
      _adrenalineTimer =
          Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (state.adrenalineTime > 0) {
          emit(state.copyWith(adrenalineTime: state.adrenalineTime - 1));
          if (state.adrenalineTime == 30) {
            showSnackBar(AclsAlert.prepararTrocaDeSocorrista);
          } else if (state.adrenalineTime == 15) {
            showSnackBar(AclsAlert.prepararChecagemRitmoEPulso);
          }
        } else {
          _adrenalineTimer?.cancel();
          emit(state.copyWith(adrenalineTime: 120));
          showSnackBar(AclsAlert.checarRitmoEPulso);
          await Future.delayed(const Duration(seconds: 10));
          showSnackBar(AclsAlert.tempoEntreCompressoes);
        }
      });
    }
  }

  void selectFrequency(AclsHeartFrequency frequency) async {
    emit(state.copyWith(heartFrequency: frequency));
    if (frequency == AclsHeartFrequency.assistolia) {
      showSnackBar(AclsAlert.checarCAGADA);
    }
  }

  void addMedication(AclsMedication medication) {
    emit(state.copyWith(medications: [...state.medications, medication]));
    showSnackBar(AclsAlert.outraMedicacaoAdicionada);
  }

  void addEvent(String event) {
    emit(state.copyWith(events: [...state.events, event]));
    showSnackBar(AclsAlert.eventoAdicionado);
  }

  void advancedAirwayChanged() {
    emit(state.copyWith(advancedAirway: !state.advancedAirway));
    if (state.advancedAirway) {
      showSnackBar(AclsAlert.viaAeraAvancadaDisponivelACLS);
    }
  }

  void showSnackBar(AclsAlert alert) {
    emit(state.copyWith(alert: () => alert));
    emit(state.copyWith(alert: () => null));
  }

  Future<void> playSound() async {
    await _player.setAsset(Audios.metronome);
    await _player.play();
  }
}
