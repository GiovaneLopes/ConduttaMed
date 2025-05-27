import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/acls/bloc/acls/acls_cubit.dart';
import 'package:condutta_med/libs/acls/models/acls_heart_frequency.dart';
import 'package:condutta_med/modules/shared/components/default_page.dart';
import 'package:condutta_med/modules/acls/widgets/acls_frequency_card.dart';

class AclsHeartFrequencyPage extends StatelessWidget {
  const AclsHeartFrequencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultPage.withBackButton(
      title: 'Ritmo Cardíaco',
      body: Column(
        children: [
          ...AclsHeartFrequency.allValues.map(
            (frequency) => AclsFrequencyCard(
              frequency: frequency,
              onSelected: () {
                Modular.get<AclsCubit>().selectFrequency(frequency);
                Modular.to.pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
