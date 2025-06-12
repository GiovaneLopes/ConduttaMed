import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:condutta_med/libs/acls/models/activity_log.dart';

part 'acls_history_item.g.dart';

@JsonSerializable(explicitToJson: true)
class AclsHistoryItem extends Equatable {
  final String id;
  final DateTime date;
  final int duration;
  final int totalCompressionsTime;
  final int totalCompressions;
  final int totalAdrenalines;
  final int totalShocks;
  final int totalMedications;
  final int fct;
  final List<ActivityLog> activities;

  const AclsHistoryItem({
    required this.id,
    required this.date,
    this.duration = 0,
    this.totalCompressionsTime = 0,
    this.totalCompressions = 0,
    this.totalShocks = 0,
    this.totalAdrenalines = 0,
    this.totalMedications = 0,
    this.fct = 0,
    this.activities = const <ActivityLog>[],
  });

  factory AclsHistoryItem.fromJson(Map<String, dynamic> json) =>
      _$AclsHistoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$AclsHistoryItemToJson(this);

  @override
  List<Object?> get props => [
        id,
        date,
        duration,
        totalCompressionsTime,
        totalCompressions,
        totalAdrenalines,
        totalShocks,
        totalMedications,
        fct,
        activities,
      ];
}
