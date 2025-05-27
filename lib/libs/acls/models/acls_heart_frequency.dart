import 'package:condutta_med/modules/shared/resources/images.dart';

enum AclsHeartFrequency {
  fv,
  tvsp,
  assistolia,
  aesp,
  unknown;

  @override
  String toString() {
    switch (this) {
      case AclsHeartFrequency.fv:
        return 'Fibrilação ventricular';
      case AclsHeartFrequency.tvsp:
        return 'Taquicardia ventricular sem pulso';
      case AclsHeartFrequency.assistolia:
        return 'Assistolia';
      case AclsHeartFrequency.aesp:
        return 'Atividade elétrica sem pulso';
      default:
        return 'Não identificado';
    }
  }

  String image() {
    switch (this) {
      case AclsHeartFrequency.fv:
        return Images.fv;
      case AclsHeartFrequency.tvsp:
        return Images.tvsp;
      case AclsHeartFrequency.assistolia:
        return Images.assistolia;
      case AclsHeartFrequency.aesp:
        return Images.aesp;
      default:
        return '';
    }
  }

  String type() {
    switch (this) {
      case AclsHeartFrequency.fv:
      case AclsHeartFrequency.tvsp:
        return 'Chocável';
      case AclsHeartFrequency.assistolia:
      case AclsHeartFrequency.aesp:
        return 'Não chocável';
      default:
        return '';
    }
  }

  static List<AclsHeartFrequency> get allValues => [
        AclsHeartFrequency.fv,
        AclsHeartFrequency.tvsp,
        AclsHeartFrequency.assistolia,
        AclsHeartFrequency.aesp,
      ];
}
