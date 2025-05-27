import 'package:condutta_med/modules/shared/utils/app_route.dart';
// ignore_for_file: overridden_fields, annotate_overrides

class AuthRoutes extends AppRoute {
  final String name;
  final NavigatorType? type;
  AuthRoutes(this.name, {this.type}) : super(module: '/auth');

  // static final login = AuthRoutes('/');
  static final registration = AuthRoutes('/registration');
  static final passwordRecover = AuthRoutes('/password-recover');
  static final emailConfirmation = AuthRoutes(
    '/email-confirmation',
    type: NavigatorType.pushReplacement,
  );
}
