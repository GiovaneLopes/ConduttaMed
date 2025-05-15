import 'modules/auth/auth_routes.dart';
import 'package:condutta_med/app_routes.dart';
import 'modules/shared/components/success_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/home/home_module.dart';
import 'package:condutta_med/modules/home/home_routes.dart';
import 'package:condutta_med/modules/auth/auth_module.dart';
import 'package:condutta_med/modules/auth/bloc/auth_cubit.dart';
import 'package:condutta_med/modules/profile/profile_module.dart';
import 'package:condutta_med/modules/profile/profile_routes.dart';
import 'package:condutta_med/modules/intro/pages/splash_page.dart';
import 'package:condutta_med/libs/user/datasource/user_datasource.dart';
import 'package:condutta_med/libs/user/repository/user_repository.dart';
import 'package:condutta_med/modules/shared/components/error_page.dart';


class AppModule extends Module {
  @override
  List<Bind> binds = [
    Bind.lazySingleton<UserDatasource>((i) => UserDatasourceImpl()),
    Bind.lazySingleton<UserRepository>((i) => UserRepositoryImpl(i())),
    Bind.singleton<AuthCubit>((i) => AuthCubit(i())),
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => const SplashPage(),
    ),
    ChildRoute(
      AppRoutes.error.name,
      transition: TransitionType.rightToLeft,
      child: (context, args) => const ErrorPage(),
    ),
    ChildRoute(
      AppRoutes.success.name,
      transition: TransitionType.rightToLeft,
      child: (context, args) => const SuccessPage(),
    ),
    ModuleRoute(
      AuthRoutes.login.module,
      transition: TransitionType.rightToLeft,
      module: AuthModule(),
    ),
    ModuleRoute(
      HomeRoutes.home.module,
      module: HomeModule(),
    ),
    ModuleRoute(
      ProfileRoutes.profile.module,
      module: ProfileModule(),
    ),
  ];
}
