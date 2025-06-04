import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/acls/acls_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/components/default_page.dart';
import 'package:condutta_med/modules/shared/components/icon_navigation_tile.dart';
import 'package:condutta_med/modules/acls/bloc/acls_settings/acls_settings_cubit.dart';

class AclsInitialPage extends StatelessWidget {
  const AclsInitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultPage.withBackButton(
      title: 'ACLS',
      body: Column(
        children: [
          SizedBox(height: 28.h),
          BlocBuilder<AclsSettingsCubit, AclsSettingsState>(
              bloc: Modular.get<AclsSettingsCubit>(),
              builder: (context, state) {
                return IconNavigationTile(
                  icon: Icons.play_circle_outline,
                  value: 'Iniciar',
                  onTap: AclsRoutes.acls.navigate,
                );
              }),
          IconNavigationTile(
            icon: Icons.insert_drive_file_outlined,
            value: 'Histórico',
            onTap: () {},
          ),
          IconNavigationTile(
            icon: Icons.settings_outlined,
            value: 'Configurações',
            onTap: AclsRoutes.aclsSettings.navigate,
          ),
        ],
      ),
    );
  }
}
