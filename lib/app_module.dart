import 'modules/auth/auth_routes.dart';
import 'package:condutta_med/app_bloc.dart';
import 'modules/shared/components/success_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/auth/auth_module.dart';
import 'package:condutta_med/modules/intro/pages/splash_page.dart';
import 'package:condutta_med/modules/shared/components/error_page.dart';


class AppModule extends Module {
  @override
  List<Bind> binds = [
    Bind.singleton((i) => AppBloc()),
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => const SplashPage(),
    ),
    ChildRoute(
      '/error',
      child: (context, args) => const ErrorPage(),
    ),
    ChildRoute(
      '/success',
      child: (context, args) => const SuccessPage(),
    ),
    ModuleRoute(
      AuthRoutes.login.module,
      transition: TransitionType.rightToLeft,
      module: AuthModule(),
    ),
  ];
}
