import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/acls/acls_routes.dart';
import 'package:condutta_med/modules/shared/components/default_page.dart';
import 'package:condutta_med/modules/shared/components/icon_navigation_tile.dart';
import 'package:condutta_med/modules/acls/bloc/acls_history/acls_history_cubit.dart';

class AclsHistoryPage extends StatefulWidget {
  const AclsHistoryPage({
    super.key,
  });

  @override
  State<AclsHistoryPage> createState() => _AclsHistoryPageState();
}

class _AclsHistoryPageState extends State<AclsHistoryPage> {
  final bloc = Modular.get<AclsHistoryCubit>();

  @override
  void initState() {
    super.initState();
    bloc.loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<AclsHistoryCubit>();
    return DefaultPage.withBackButton(
        title: 'Histórico',
        body: BlocBuilder<AclsHistoryCubit, AclsHistoryState>(
            bloc: bloc,
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                    state.history.length,
                    (item) => GestureDetector(
                          onTap: () {
                            bloc.selectHistoryItem(state.history[item]);
                            AclsRoutes.aclsHistoryItem.navigate();
                          },
                          child: IconNavigationTile(
                            value:
                                'ACLS: ${state.getFormattedDateWithTime(state.history[item].date)}',
                            icon: Icons.insert_drive_file_outlined,
                            onTap: () {
                              bloc.selectHistoryItem(state.history[item]);
                              AclsRoutes.aclsHistoryItem.navigate();
                            },
                          ),
                        )),
              );
            }));
  }
}
