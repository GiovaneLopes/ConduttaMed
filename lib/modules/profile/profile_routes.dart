import 'package:condutta_med/modules/shared/utils/app_route.dart';
// ignore_for_file: annotate_overrides, overridden_fields

class ProfileRoutes extends AppRoute {
  final String name;
  ProfileRoutes(this.name) : super(module: '/profile');

  static final profile = ProfileRoutes('/');
}
