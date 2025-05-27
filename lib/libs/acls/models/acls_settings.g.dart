// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acls_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AclsSettings _$AclsSettingsFromJson(Map<String, dynamic> json) => AclsSettings(
      defaultFrequency: (json['defaultFrequency'] as num?)?.toInt() ?? 100,
      defaultTime: (json['defaultTime'] as num?)?.toInt() ?? 3,
      showInitialSuggestions: json['showInitialSuggestions'] as bool? ?? true,
      events: (json['events'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [
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
            'Acesso venoso profundo'
          ],
      medications: (json['medications'] as List<dynamic>?)
              ?.map((e) => AclsMedication.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [
            AclsMedication(
                name: "Sulfato de magnésio",
                infusion: "Verifique a diluição da instituição"),
            AclsMedication(
                name: "Cloreto de potássio (KCl) 19,1%",
                infusion: "Verifique a diluição da instituição"),
            AclsMedication(
                name: "Atropina",
                infusion: "Verifique a diluição da instituição"),
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
                name: "Naloxona",
                infusion: "Verifique a diluição da instituição"),
            AclsMedication(
                name: "Flumazenil",
                infusion: "Verifique a diluição da instituição")
          ],
    );

Map<String, dynamic> _$AclsSettingsToJson(AclsSettings instance) =>
    <String, dynamic>{
      'defaultFrequency': instance.defaultFrequency,
      'defaultTime': instance.defaultTime,
      'showInitialSuggestions': instance.showInitialSuggestions,
      'events': instance.events,
      'medications': instance.medications.map((e) => e.toJson()).toList(),
    };
