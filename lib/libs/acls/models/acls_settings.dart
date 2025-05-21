import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:condutta_med/libs/acls/models/acls_medications.dart';

part 'acls_settings.g.dart';

@JsonSerializable(explicitToJson: true)
class AclsSettings extends Equatable {
  final int defaultFrequency;
  final int defaultTime;
  final List<String> events;
  final List<AclsMedication> medications;

  const AclsSettings({
    this.defaultFrequency = 100,
    this.defaultTime = 3,
    this.events = const [
      'Monitorização',
      'Ventilação',
      'Acesso venoso periférico',
      'Glicemia capilar',
      'Gasometria arterial',
      'Acesso intraósseo',
      'Gasometria venosa',
      'Manta térmica',
      'Drenagem de tórax',
      'Drenagem de pericárdio',
      'Acesso venoso profundo',
    ],
    this.medications = const [
      AclsMedication(
          name: "Sulfato de magnésio",
          infusion: "Verifique a diluição da instituição"),
      AclsMedication(
          name: "Cloreto de potássio (KCl) 19,1%",
          infusion: "Verifique a diluição da instituição"),
      AclsMedication(
          name: "Atropina", infusion: "Verifique a diluição da instituição"),
      AclsMedication(
          name: "Cloreto de potássio (KCl) 10%",
          infusion: "Verifique a diluição da instituição"),
      AclsMedication(
          name: "Gluconato de cálcio 10%",
          infusion: "Verifique a diluição da instituição"),
      AclsMedication(
          name: "Bicarbonato de sódio 8,4%",
          infusion: "Verifique a diluição da instituição"),
      AclsMedication(
          name: "Glicoinsulino terapia",
          infusion: "Verifique a diluição da instituição"),
      AclsMedication(
          name: "Naloxona", infusion: "Verifique a diluição da instituição"),
      AclsMedication(
          name: "Flumazenil", infusion: "Verifique a diluição da instituição"),
    ],
  });

  AclsSettings copyWith({
    int? defaultFrequency,
    int? defaultTime,
    List<String>? events,
    List<AclsMedication>? medications,
  }) {
    return AclsSettings(
      defaultFrequency: defaultFrequency ?? this.defaultFrequency,
      defaultTime: defaultTime ?? this.defaultTime,
      events: events ?? this.events,
      medications: medications ?? this.medications,
    );
  }

  factory AclsSettings.fromJson(Map<String, dynamic> json) =>
      _$AclsSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$AclsSettingsToJson(this);

  @override
  List<Object> get props => [
        defaultFrequency,
        defaultTime,
        events,
        medications,
      ];
}
