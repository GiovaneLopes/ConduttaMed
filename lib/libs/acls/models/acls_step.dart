enum AclsStep {
  frequency,
  massage,
  shock,
  medication,
  rateAndPulse;

  @override
  String toString() {
    switch (this) {
      case AclsStep.frequency:
        return 'Identificar ritmo de parada';
      case AclsStep.massage:
        return 'Iniciar massagem cardíaca';
      case AclsStep.shock:
        return 'Administrar Choque';
      case AclsStep.medication:
        return 'Administrar medicação';
      case AclsStep.rateAndPulse:
        return 'Checar pulso e ritmo de parada';
    }
  }
}
