import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:condutta_med/libs/acls/models/acls_alert.dart';
import 'package:condutta_med/libs/src/exceptions/app_error.dart';
import 'package:condutta_med/libs/acls/models/acls_settings.dart';
import 'package:condutta_med/libs/acls/models/acls_medications.dart';
import 'package:condutta_med/libs/acls/models/acls_heart_frequency.dart';
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
  AclsCubit(this.settingsCubit) : super(const AclsState()) {
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
}
