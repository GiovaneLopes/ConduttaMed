import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/acls/acls_routes.dart';
import 'package:condutta_med/modules/acls/pages/acls_page.dart';
import 'package:condutta_med/modules/acls/bloc/acls/acls_cubit.dart';
import 'package:condutta_med/modules/acls/pages/acls_events_page.dart';
import 'package:condutta_med/libs/acls/repository/acls_repository.dart';
import 'package:condutta_med/modules/acls/pages/acls_initial_page.dart';
import 'package:condutta_med/modules/acls/pages/acls_settings_page.dart';
import 'package:condutta_med/modules/acls/pages/acls_protocol_image.dart';
import 'package:condutta_med/modules/acls/pages/acls_medications_page.dart';
import 'package:condutta_med/libs/acls/datasource/acls_local_data_source.dart';
import 'package:condutta_med/modules/acls/pages/acls_heart_frequency_page.dart';
import 'package:condutta_med/modules/acls/pages/acls_settings_events_page.dart';
import 'package:condutta_med/libs/acls/datasource/acls_remote_data_source.dart';
import 'package:condutta_med/modules/acls/pages/acls_settings_medications_page.dart';
import 'package:condutta_med/modules/acls/bloc/acls_settings/acls_settings_cubit.dart';

class AclsModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => AclsLocalDataSourceImpl()),
        Bind.singleton((i) => AclsRemoteDataSourceImpl()),
        Bind.lazySingleton((i) => AclsRespositoryImpl(i(), i())),
        Bind.lazySingleton((i) => AclsSettingsCubit(i(), i())),
        Bind.lazySingleton((i) => AclsCubit(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          AclsRoutes.initial.name,
          child: (context, args) => const AclsInitialPage(),
        ),
        ChildRoute(
          AclsRoutes.acls.name,
          child: (context, args) => const AclsPage(),
        ),
        ChildRoute(
          AclsRoutes.heartFrequency.name,
          child: (context, args) => const AclsHeartFrequencyPage(),
        ),
        ChildRoute(
          AclsRoutes.flow.name,
          child: (context, args) => const AclsProtocolImage(),
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
        ChildRoute(
          AclsRoutes.settingsEvents.name,
          child: (context, args) => const AclsSettingsEventsPage(),
        ),
        ChildRoute(
          AclsRoutes.settingsMedications.name,
          child: (context, args) => const AclsSettingsMedicationsPage(),
        ),
      ];
}
