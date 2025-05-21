import 'package:condutta_med/modules/shared/utils/app_route.dart';
// ignore_for_file: overridden_fields, annotate_overrides

class AclsRoutes extends AppRoute {
  final String name;
  AclsRoutes(this.name) : super(module: '/acls');

  static final AclsRoutes initial = AclsRoutes('/');
  static final AclsRoutes aclsSettings = AclsRoutes('/settings');
  static final AclsRoutes events = AclsRoutes('/events');
  static final AclsRoutes medications = AclsRoutes('/medications');
}
