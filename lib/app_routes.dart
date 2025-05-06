import 'package:condutta_med/modules/shared/utils/app_route.dart';
// ignore_for_file: overridden_fields, annotate_overrides

class AppRoutes extends AppRoute {
  final String name;
  final NavigatorType? type;
  AppRoutes(this.name, {this.type}) : super();

  static final error = AppRoutes('/error');
  static final success = AppRoutes('/success');
}
