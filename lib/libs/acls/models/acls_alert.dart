import 'package:condutta_med/modules/shared/components/snackbar_widget.dart';

enum AclsAlert {
  naoChocavel5Hs5Ts,
  naoChocavel6Hs5Ts,
  ritmoNaoIdentificado,
  desfibriladorNaoDisponivel,
  checarCAGADA,
  medicacaoERitmoNaoIdentificado,
  medicacaoSemMassagem,
  medicacaoAntesDoTempo,
  medicacaoRecomendada,
  choquePorUltimo,
  choqueRecomendado,
  reiniciarMassagemAntesDeOutroChoque,
  tempoEntreCompressoes,
  adrenalinaPrimeiro,
  adrenalinaRecomendada,
  amiodaronaPALSRecomendada,
  amiodarona300Lidocaina1Recomendada,
  amiodarona150Lidocaina05Recomendada,
  prepararChecagemRitmoEPulso,
  prepararTrocaDeSocorrista,
  checarRitmoEPulso,
  viaAeraAvancadaDisponivelACLS,
  viaAeraAvancadaDisponivelPALS,
  checar5hse5ts,
  checar6hse5ts,
  adrenalinaAdicionada,
  eventoAdicionado,
  outraMedicacaoAdicionada,
  amiodarona5Adicionada,
  amiodarona300Adicionada,
  amiodarona150Adicionada,
  lidocaina1Adicionada,
  lidocaina05Adicionada,
  viaAereaAvancada,
  choqueAdicionado;

  String get title {
    switch (this) {
      case AclsAlert.naoChocavel5Hs5Ts:
        return "Choque não recomendado";
      case AclsAlert.naoChocavel6Hs5Ts:
        return "Choque não recomendado";
      case AclsAlert.ritmoNaoIdentificado:
        return "Ritmo não identificado";
      case AclsAlert.desfibriladorNaoDisponivel:
        return "Desfibrilador não disponível";
      case AclsAlert.checarCAGADA:
        return "Checar mneumônico CA GA DA";
      case AclsAlert.medicacaoERitmoNaoIdentificado:
        return "Ritmo ainda não identificado";
      case AclsAlert.medicacaoSemMassagem:
        return "Iniciar compressões torácicas";
      case AclsAlert.medicacaoAntesDoTempo:
        return "Última medicação há menos de 3 minutos";
      case AclsAlert.medicacaoRecomendada:
        return "Administrar medicação";
      case AclsAlert.choquePorUltimo:
        return "Choque não recomendado";
      case AclsAlert.adrenalinaPrimeiro:
        return "Adrenalina recomendada";
      case AclsAlert.adrenalinaRecomendada:
        return "Adrenalina recomendada";
      case AclsAlert.choqueRecomendado:
        return "Choque recomendado";
      case AclsAlert.reiniciarMassagemAntesDeOutroChoque:
        return "Iniciar compressões torácicas!";
      case AclsAlert.tempoEntreCompressoes:
        return "Reiniciar compressões torácicas!";
      case AclsAlert.amiodaronaPALSRecomendada:
        return "Amiodarona 300 mg / Lidocaína 1-1,5 mg/kg recomendada";
      case AclsAlert.amiodarona300Lidocaina1Recomendada:
        return "Amiodarona 300 mg / Lidocaína 1-1,5 mg/kg recomendada";
      case AclsAlert.amiodarona150Lidocaina05Recomendada:
        return "Amiodarona 150 mg /Lidocaína 0,5-0,75 mg/kg recomendada";
      case AclsAlert.checarRitmoEPulso:
        return "Checar Ritmo e Pulso";
      case AclsAlert.viaAeraAvancadaDisponivelACLS:
        return "Via aérea avançada disponível";
      case AclsAlert.viaAeraAvancadaDisponivelPALS:
        return "Via aérea avançada disponível";
      case AclsAlert.checar5hse5ts:
        return "Causas alternativas de PCR";
      case AclsAlert.checar6hse5ts:
        return "Causas alternativas de PCR";
      case AclsAlert.prepararChecagemRitmoEPulso:
        return "Preparar equipe para checagem de ritmo e pulso após ciclo de compressão!";
      case AclsAlert.prepararTrocaDeSocorrista:
        return "Preparar troca de socorrista responsável pela compressão";
      case AclsAlert.adrenalinaAdicionada:
        return "Adrenalina adicionada";
      case AclsAlert.eventoAdicionado:
        return "Evento adicionado";
      case AclsAlert.outraMedicacaoAdicionada:
        return "Outra medicação adicionada";
      case AclsAlert.amiodarona5Adicionada:
        return "Amiodarona 5 mg/kg adicionada";
      case AclsAlert.amiodarona300Adicionada:
        return "Amiodarona 300 mg adicionada";
      case AclsAlert.amiodarona150Adicionada:
        return "Amiodarona 150 mg adicionada";
      case AclsAlert.lidocaina1Adicionada:
        return "Lidocaína 1-1,5 mg/kg adicionada";
      case AclsAlert.lidocaina05Adicionada:
        return "Lidocaína 0,5-0,75 mg/kg adicionada";
      case AclsAlert.viaAereaAvancada:
        return "Via aérea avançada";
      case AclsAlert.choqueAdicionado:
        return "Choque adicionado";
    }
  }

  String get message {
    switch (this) {
      case AclsAlert.naoChocavel5Hs5Ts:
        return "Nos ritmos de AESP ou Assistolia o choque não é recomendado.\nProcurar causas reversíveis para a parada cardíada: 5Hs e 5Ts";
      case AclsAlert.naoChocavel6Hs5Ts:
        return "Nos ritmos de AESP ou Assistolia o choque não é recomendado.\nProcurar causas reversíveis para a parada cardíada: 6Hs e 5Ts";
      case AclsAlert.ritmoNaoIdentificado:
        return "Verifique o ritmo antes de aplicar choque no paciente!\nCaso o ritmo seja AESP ou Assistolia o choque não é recomendado";
      case AclsAlert.desfibriladorNaoDisponivel:
        return "Solicite o DEA / Desfibrilador o mais rápido possível!";
      case AclsAlert.checarCAGADA:
        return "Checar CABOS / GANHO / DERIVAÇÃO";
      case AclsAlert.medicacaoERitmoNaoIdentificado:
        return "Verifique o ritmo ao final do ciclo de compressão!";
      case AclsAlert.medicacaoSemMassagem:
        return "A medicação deve ser administrada durante a compressão torácica!";
      case AclsAlert.medicacaoAntesDoTempo:
        return "A diferença de tempo entre as medicações deve ser entre 3 a 5 minutos";
      case AclsAlert.medicacaoRecomendada:
        return "Já acabou o ciclo da última medicação. Administrar nova medicação.";
      case AclsAlert.choquePorUltimo:
        return "Um choque acabou de ser feito.\nVerifique o próximo medicamento a ser administrado";
      case AclsAlert.choqueRecomendado:
        return "Este ritmo é chocável e é recomendado administrar choque!";
      case AclsAlert.reiniciarMassagemAntesDeOutroChoque:
        return "Deve ser realizado 1 ciclo de compressão torácica entre os choques";
      case AclsAlert.tempoEntreCompressoes:
        return "Deve-se reiniciar as compressões torácicas. O tempo máximo entre 1 ciclo de compressão e outro deve ser idealmente de no máximo 10 segundos";
      case AclsAlert.adrenalinaPrimeiro:
        return "A adrenalina deve ser a primeira medicação a ser feita";
      case AclsAlert.adrenalinaRecomendada:
        return "É recomendável que a droga administrada seja a adrenalina";
      case AclsAlert.amiodaronaPALSRecomendada:
        return "É recomendável que a droga administrada seja Amiodarona 300 mg / Lidocaína 1-1,5 mg/kg";
      case AclsAlert.amiodarona300Lidocaina1Recomendada:
        return "É recomendável que a droga administrada seja Amiodarona 300 mg / Lidocaína 1-1,5 mg/kg";
      case AclsAlert.amiodarona150Lidocaina05Recomendada:
        return "É recomendável que a droga administrada seja Amiodarona 150 mg / Lidocaína 0,5-0,75 mg/kg";
      case AclsAlert.checarRitmoEPulso:
        return "Esta etapa deve durar no máximo 10 segundos. Verifique se é necessário alterar o ritmo identificado";
      case AclsAlert.viaAeraAvancadaDisponivelACLS:
        return "A frequência de compressões deve ser contínua e as ventilações para 1 a cada 6 segundos. Instale também capnografia para monitorizar a qualidade das compressões";
      case AclsAlert.viaAeraAvancadaDisponivelPALS:
        return "A frequência de compressões deve ser contínua e as ventilações para 1 a cada 2-3 segundos. Instale também capnografia para monitorizar a qualidade das compressões";
      case AclsAlert.checar5hse5ts:
        return "Comece a investigar outras causas de PCR, pensando inicialmente nos 5 Hs e 5 Ts. Caso não se recorde vá no botão de ajuda no canto superior direito para ajuda";
      case AclsAlert.checar6hse5ts:
        return "Comece a investigar outras causas de PCR, pensando inicialmente nos 6 Hs e 5 Ts. Caso não se recorde vá no botão de ajuda no canto superior direito para ajuda";
      case AclsAlert.prepararChecagemRitmoEPulso:
        return "Preparar equipe para checagem de ritmo e pulso após ciclo de compressão!\nCarregue o desfibrilador e acompanhe o pulso antes o final do ciclo!";
      case AclsAlert.prepararTrocaDeSocorrista:
        return "Avisar troca de socorrista responsável pela compressão em 30 segundos";
      case AclsAlert.adrenalinaAdicionada:
        return "Verificar próxima etapa";
      case AclsAlert.eventoAdicionado:
        return "Evento adicionado";
      case AclsAlert.outraMedicacaoAdicionada:
        return "Outra medicação adicionada";
      case AclsAlert.amiodarona300Adicionada:
        return "Verificar próxima etapa";
      case AclsAlert.amiodarona5Adicionada:
      case AclsAlert.amiodarona150Adicionada:
      case AclsAlert.lidocaina1Adicionada:
      case AclsAlert.lidocaina05Adicionada:
        return "Verificar próxima etapa";
      case AclsAlert.viaAereaAvancada:
        return "Considere via aérea avançada (intubação orotraqueal ou dispositivos extraglóticos) e verificação da qualidade da ACLS por capnografia";
      case AclsAlert.choqueAdicionado:
        return "Reinicie imediatamente um novo ciclo de compressão torácica";
    }
  }

  SnackbarWidgetType get type {
    switch (this) {
      case AclsAlert.naoChocavel5Hs5Ts:
      case AclsAlert.naoChocavel6Hs5Ts:
      case AclsAlert.ritmoNaoIdentificado:
      case AclsAlert.desfibriladorNaoDisponivel:
      case AclsAlert.checarCAGADA:
      case AclsAlert.medicacaoERitmoNaoIdentificado:
      case AclsAlert.medicacaoSemMassagem:
      case AclsAlert.medicacaoAntesDoTempo:
      case AclsAlert.choquePorUltimo:
      case AclsAlert.choqueRecomendado:
      case AclsAlert.reiniciarMassagemAntesDeOutroChoque:
      case AclsAlert.tempoEntreCompressoes:
      case AclsAlert.adrenalinaPrimeiro:
      case AclsAlert.adrenalinaRecomendada:
      case AclsAlert.amiodaronaPALSRecomendada:
      case AclsAlert.amiodarona300Lidocaina1Recomendada:
      case AclsAlert.amiodarona150Lidocaina05Recomendada:
      case AclsAlert.checarRitmoEPulso:
      case AclsAlert.prepararChecagemRitmoEPulso:
        return SnackbarWidgetType.error;
      case AclsAlert.checar5hse5ts:
      case AclsAlert.checar6hse5ts:
      case AclsAlert.prepararTrocaDeSocorrista:
      case AclsAlert.medicacaoRecomendada:
      case AclsAlert.viaAereaAvancada:
        return SnackbarWidgetType.warning;
      default:
        return SnackbarWidgetType.success;
    }
  }
}
