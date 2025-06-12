import 'package:json_annotation/json_annotation.dart';

part 'activity_log.g.dart';

@JsonSerializable()
class ActivityLog {
  final String time;
  final String title;

  ActivityLog(
    this.time,
    this.title,
  );

  factory ActivityLog.fromJson(Map<String, dynamic> json) =>
      _$ActivityLogFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityLogToJson(this);
}
