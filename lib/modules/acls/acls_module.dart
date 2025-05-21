import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/acls/acls_routes.dart';
import 'package:condutta_med/modules/acls/pages/acls_events_page.dart';
import 'package:condutta_med/libs/acls/repository/acls_repository.dart';
import 'package:condutta_med/modules/acls/pages/acls_initial_page.dart';
import 'package:condutta_med/modules/acls/pages/acls_settings_page.dart';
import 'package:condutta_med/modules/acls/pages/acls_medications_page.dart';
import 'package:condutta_med/libs/acls/datasource/acls_local_data_source.dart';
import 'package:condutta_med/libs/acls/datasource/acls_remote_data_source.dart';
import 'package:condutta_med/modules/acls/bloc/acls_settings/acls_settings_cubit.dart';

class AclsModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => AclsLocalDataSourceImpl()),
        Bind.singleton((i) => AclsRemoteDataSourceImpl()),
        Bind.lazySingleton((i) => AclsRespositoryImpl(i(), i())),
        Bind.lazySingleton((i) => AclsSettingsCubit(i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          AclsRoutes.initial.name,
          child: (context, args) => const AclsInitialPage(),
        ),
        ChildRoute(
          AclsRoutes.aclsSettings.name,
          child: (context, args) => const AclsSettingsPage(),
        ),
        ChildRoute(
          AclsRoutes.events.name,
          child: (context, args) => const AclsEventsPage(),
        ),
        ChildRoute(
          AclsRoutes.medications.name,
          child: (context, args) => const AclsMedicationsPage(),
        ),
      ];
}
