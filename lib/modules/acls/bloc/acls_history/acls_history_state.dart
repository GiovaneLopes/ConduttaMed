part of 'acls_history_cubit.dart';

class AclsHistoryState {
  final List<AclsHistoryItem> history;
  final AclsHistoryItem? selected;
  final AclsHistoryStatus status;

  AclsHistoryState({
    this.history = const <AclsHistoryItem>[],
    this.selected,
    this.status = AclsHistoryStatus.initial,
  });

  String getFormattedDateWithTime(DateTime date) {
    return '${date.toLocal().toIso8601String().substring(0, 10)} ${date.toLocal().toIso8601String().substring(11, 16)}';
  }

  String formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  AclsHistoryState copyWith({
    List<AclsHistoryItem>? history,
    AclsHistoryItem? selected,
    AclsHistoryStatus? status,
  }) {
    return AclsHistoryState(
      history: history ?? this.history,
      selected: selected ?? this.selected,
      status: status ?? this.status,
    );
  }
}
