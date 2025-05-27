class AclsHelpItem {
  final String title;
  final List<String> items;

  AclsHelpItem({
    required this.title,
    required this.items,
  });

  static List<AclsHelpItem> get values => [
        AclsHelpItem(
          title: 'Qualidade da RCP',
          items: [
            ' - Comprima o tórax com força para afundar de 5-6 cm, permitindo o retorno total do tórax antes da próxima compressão, com velocidade entre 100 a 120 compressões/min.',
            ' - Minimize interrupções nas compressões.',
            ' - Evite ventilações excessivas.',
            ' - Alterne os responsáveis pelas compressões a cada 2 minutos ou antes, se houver cansaço.',
            ' - Sem via áerea avançada, relação compressão-ventilação de 30:2.',
            ' - Capnografia quantitativa com forma de onda:\n- Se PETCO2 estiver baixo ou caindo, reavalie a qualidade da ACLS.'
          ],
        ),
        AclsHelpItem(
          title: 'Carga do choque para desfibrilação',
          items: [
            ' - Bifásica: Recomendação do fabricanteSe desconhecida utilizar o máximo disponívelA segunda dose e a subsequentes devem ser equivalentes, podendo ser consideradas doses mais altas.',
            ' - Monofásica: 360 J.'
          ],
        ),
        AclsHelpItem(
          title: 'Tratamento medicamentoso',
          items: [
            ' - Dose IV/IO de epinefrina: 1 mg a cada 3 a 5 minutos',
            ' - Outras drogas:\nDose IV/IO de amiodarona:\nPrimeira dose: Bolus de 300 mg\nSegunda dose: 150 mg\nou\nDose IV/IO de lidocaína:\nPrimeira dose: 1 a 1,5 mg/kg\nSegunda dose: 0,5 a 0,75 mg/kg'
          ],
        ),
        AclsHelpItem(
          title: 'Via aérea avançada',
          items: [
            ' - Intubação endotraqueal ou via aérea extraglótica avançada',
            ' - Capnografia com forma de onda ou capnometria para confirmar e monitorar o posicionamento do tubo ET',
            ' - Quando houver uma via aérea avançada administre 1 ventilação a cada 6 segundos (10 ventilações/min) com compressões torácicas contínuas'
          ],
        ),
        AclsHelpItem(
          title: 'Retorno à circulação espontânea (RCE)',
          items: [
            ' - Pulso e pressão arterial',
            ' - Aumento abrupto prolongado na PETCO2 (tipicamente maior ou igual a 40 mmHg)',
            ' - Ondas de pressão arterial espontânea com monitoramento intra-arterial'
          ],
        ),
        AclsHelpItem(
          title: 'Causas reversíveis',
          items: [
            ' - Hipovolemia',
            ' - Hipóxia',
            ' - Hidrogênio (H+: acidemia/pH)',
            ' - Hipotermia',
            ' - Hipo/Hipercalemia (K+)',
            ' - PneumoTórax Hipertensivo',
            ' - Tamponamento cardíaco',
            ' - Toxinas',
            ' - Trombose coronária (IAM)',
            ' - Trombose pulmonar (TEP)'
          ],
        ),
      ];
}
