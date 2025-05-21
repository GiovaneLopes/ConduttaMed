import 'package:flutter/material.dart';
import 'package:condutta_med/modules/acls/acls_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/components/default_page.dart';
import 'package:condutta_med/modules/shared/components/icon_navigation_tile.dart';

class AclsInitialPage extends StatelessWidget {
  const AclsInitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultPage.withBackButton(
      title: 'ACLS',
      body: Column(
        children: [
          SizedBox(height: 28.h),
          IconNavigationTile(
            icon: Icons.play_circle_outline,
            title: 'Iniciar',
            onTap: () {},
          ),
          IconNavigationTile(
            icon: Icons.insert_drive_file_outlined,
            title: 'Histórico',
            onTap: () {},
          ),
          IconNavigationTile(
            icon: Icons.settings_outlined,
            title: 'Configurações',
            onTap: AclsRoutes.aclsSettings.navigate,
          ),
        ],
      ),
    );
  }
}
