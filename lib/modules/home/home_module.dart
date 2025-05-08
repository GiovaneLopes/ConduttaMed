import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/home/home_routes.dart';
import 'package:condutta_med/modules/home/pages/home_page.dart';

class HomeModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          HomeRoutes.home.name,
          child: (context, args) => const HomePage(),
        ),
      ];
}
