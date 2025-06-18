import 'package:share_plus/share_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/shared/utils/app_pdf.dart';
import 'package:condutta_med/modules/auth/bloc/auth_cubit.dart';
import 'package:condutta_med/libs/acls/models/acls_history_item.dart';
import 'package:condutta_med/libs/acls/repository/acls_repository.dart';

part 'acls_history_state.dart';

enum AclsHistoryStatus {
  initial,
  loading,
  loaded,
  error,
}

class AclsHistoryCubit extends Cubit<AclsHistoryState> {
  final AclsRespository repository;
  String? get userId => Modular.get<AuthCubit>().state.user?.id;

  AclsHistoryCubit(this.repository) : super(AclsHistoryState());

  Future<void> loadHistory() async {
    emit(state.copyWith(status: AclsHistoryStatus.loading));
    final history = await repository.loadHistory(userId);
    emit(state.copyWith(
      history: history,
      status: AclsHistoryStatus.loaded,
    ));
  }

  Future<void> deleteHistoryItem(String id) async {
    final updatedHistory =
        state.history.where((item) => item.id != id).toList();
    await repository.saveHistory(userId, updatedHistory);
    emit(state.copyWith(history: updatedHistory));
  }

  Future<void> saveHistory(AclsHistoryItem item) async {
    final updatedHistory = [
      ...state.history,
      item,
    ];
    final limitedHistory = updatedHistory.length > 10
        ? updatedHistory.sublist(0, 10)
        : updatedHistory;
    emit(state.copyWith(history: limitedHistory));
    await repository.saveHistory(userId, state.history);
    emit(state.copyWith(status: AclsHistoryStatus.loaded));
  }

  Future<void> selectHistoryItem(AclsHistoryItem item) async {
    emit(state.copyWith(selected: item));
  }

  Future<void> sharePdf(AclsHistoryItem item) async {
    final pdfFile = await AppPdf.generatePdf(item);
    SharePlus.instance.share(ShareParams(files: [XFile(pdfFile.path)]));
  }
}
