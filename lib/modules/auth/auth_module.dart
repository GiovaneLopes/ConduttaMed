import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/auth/auth_routes.dart';
import 'package:condutta_med/modules/auth/pages/login_page.dart';
import 'package:condutta_med/modules/auth/pages/registration_page.dart';
import 'package:condutta_med/modules/auth/pages/password_recover_page.dart';
import 'package:condutta_med/modules/auth/pages/email_confirmation_page.dart';

class AuthModule extends Module {
  @override
  List<ModularRoute> routes = [
    ChildRoute(
      AuthRoutes.login.name,
      child: (context, args) => const LoginPage(),
      transition: TransitionType.rightToLeft,
    ),
    ChildRoute(
      AuthRoutes.registration.name,
      child: (context, args) => const RegistrationPage(),
      transition: TransitionType.rightToLeft,
    ),
    ChildRoute(
      AuthRoutes.passwordRecover.name,
      child: (context, args) => const PasswordRecoverPage(),
      transition: TransitionType.rightToLeft,
    ),
    ChildRoute(
      AuthRoutes.emailConfirmation.name,
      child: (context, args) => const EmailConfirmationPage(),
      transition: TransitionType.rightToLeft,
    ),
  ];
}
