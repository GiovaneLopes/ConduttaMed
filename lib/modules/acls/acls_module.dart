import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/acls/acls_routes.dart';
import 'package:condutta_med/modules/acls/pages/acls_page.dart';
import 'package:condutta_med/modules/acls/bloc/acls/acls_cubit.dart';
import 'package:condutta_med/modules/acls/pages/acls_finish_page.dart';
import 'package:condutta_med/modules/acls/pages/acls_events_page.dart';
import 'package:condutta_med/modules/acls/pages/acls_history_page.dart';
import 'package:condutta_med/modules/acls/pages/acls_initial_page.dart';
import 'package:condutta_med/modules/acls/pages/acls_settings_page.dart';
import 'package:condutta_med/modules/acls/pages/acls_protocol_image.dart';
import 'package:condutta_med/modules/acls/pages/acls_medications_page.dart';
import 'package:condutta_med/modules/acls/pages/acls_history_data_page.dart';
import 'package:condutta_med/modules/acls/pages/acls_heart_frequency_page.dart';
import 'package:condutta_med/modules/acls/pages/acls_settings_events_page.dart';
import 'package:condutta_med/modules/acls/pages/acls_settings_medications_page.dart';
import 'package:condutta_med/modules/acls/bloc/acls_history/acls_history_cubit.dart';
import 'package:condutta_med/modules/acls/bloc/acls_settings/acls_settings_cubit.dart';

class AclsModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => AclsHistoryCubit(i())),
        Bind.lazySingleton((i) => AclsSettingsCubit(i(), i())),
        Bind.lazySingleton((i) => AclsCubit(i(), i())),
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
          AclsRoutes.events.name,
          child: (context, args) => const AclsEventsPage(),
        ),
        ChildRoute(
          AclsRoutes.medications.name,
          child: (context, args) => const AclsMedicationsPage(),
        ),
        ChildRoute(
          AclsRoutes.finish.name,
          child: (context, args) => const AclsFinishPage(),
        ),
        ChildRoute(
          AclsRoutes.aclsSettings.name,
          child: (context, args) => const AclsSettingsPage(),
        ),
        ChildRoute(
          AclsRoutes.settingsEvents.name,
          child: (context, args) => const AclsSettingsEventsPage(),
        ),
        ChildRoute(
          AclsRoutes.settingsMedications.name,
          child: (context, args) => const AclsSettingsMedicationsPage(),
        ),
        ChildRoute(
          AclsRoutes.aclsHistory.name,
          child: (context, args) => const AclsHistoryPage(),
        ),
        ChildRoute(
          AclsRoutes.aclsHistoryItem.name,
          child: (context, args) => const AclsHistoryDataPage(),
        ),
      ];
}
