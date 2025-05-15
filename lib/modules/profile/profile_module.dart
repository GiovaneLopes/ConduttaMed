import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/profile/profile_routes.dart';
import 'package:condutta_med/modules/profile/pages/profile_page.dart';
import 'package:condutta_med/modules/profile/bloc/profile_cubit.dart';

class ProfileModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => ProfileCubit(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          ProfileRoutes.profile.name,
          child: (context, args) => const ProfilePage(),
        ),
      ];
}
