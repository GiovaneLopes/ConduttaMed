// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acls_history_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AclsHistoryItem _$AclsHistoryItemFromJson(Map<String, dynamic> json) =>
    AclsHistoryItem(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      totalCompressionsTime:
          (json['totalCompressionsTime'] as num?)?.toInt() ?? 0,
      totalCompressions: (json['totalCompressions'] as num?)?.toInt() ?? 0,
      totalShocks: (json['totalShocks'] as num?)?.toInt() ?? 0,
      totalAdrenalines: (json['totalAdrenalines'] as num?)?.toInt() ?? 0,
      totalMedications: (json['totalMedications'] as num?)?.toInt() ?? 0,
      fct: (json['fct'] as num?)?.toInt() ?? 0,
      activities: (json['activities'] as List<dynamic>?)
              ?.map((e) => ActivityLog.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ActivityLog>[],
    );

Map<String, dynamic> _$AclsHistoryItemToJson(AclsHistoryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'duration': instance.duration,
      'totalCompressionsTime': instance.totalCompressionsTime,
      'totalCompressions': instance.totalCompressions,
      'totalAdrenalines': instance.totalAdrenalines,
      'totalShocks': instance.totalShocks,
      'totalMedications': instance.totalMedications,
      'fct': instance.fct,
      'activities': instance.activities.map((e) => e.toJson()).toList(),
    };
