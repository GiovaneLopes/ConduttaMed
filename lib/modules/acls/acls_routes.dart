import 'package:condutta_med/modules/shared/utils/app_route.dart';
// ignore_for_file: overridden_fields, annotate_overrides

class AclsRoutes extends AppRoute {
  final String name;
  AclsRoutes(this.name) : super(module: '/acls');

  static final AclsRoutes initial = AclsRoutes('/');
  static final AclsRoutes acls = AclsRoutes('/acls');
  static final AclsRoutes heartFrequency = AclsRoutes('/heart-rate');
  static final AclsRoutes flow = AclsRoutes('/flow');
  static final AclsRoutes events = AclsRoutes('/events');
  static final AclsRoutes medications = AclsRoutes('/medications');
  static final AclsRoutes aclsSettings = AclsRoutes('/settings');

  static final AclsRoutes settingsEvents = AclsRoutes('/settings/events');
  static final AclsRoutes settingsMedications =
      AclsRoutes('/settings/medications');
}
