import 'package:condutta_med/libs/acls/models/activity_log.dart';

class RcpData {
  final String id;
  final String type;
  final DateTime date;
  final String totalTime;
  final String totalCompressionsTime;
  final int fct;
  final int totalCompressions;
  final int totalAdrenalines;
  final int totalShocks;
  final List<ActivityLog> activities;

  RcpData({
    required this.id,
    required this.type,
    required this.date,
    required this.totalTime,
    required this.totalCompressionsTime,
    required this.fct,
    required this.totalCompressions,
    required this.totalAdrenalines,
    required this.totalShocks,
    required this.activities,
  });
}
