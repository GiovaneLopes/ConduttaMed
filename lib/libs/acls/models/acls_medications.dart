import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'acls_medications.g.dart';

@JsonSerializable()
class AclsMedication extends Equatable {
  final String name;
  final String infusion;

  const AclsMedication({
    required this.name,
    required this.infusion,
  });

  factory AclsMedication.fromJson(Map<String, dynamic> json) =>
      _$AclsMedicationFromJson(json);

  Map<String, dynamic> toJson() => _$AclsMedicationToJson(this);

  @override
  List<Object> get props => [
        name,
        infusion,
      ];
}
