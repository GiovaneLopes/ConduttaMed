import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/acls/acls_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/components/default_page.dart';
import 'package:condutta_med/modules/shared/components/custom_dialog.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';
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
                  onTap: () {
                    if (state.settings.showInitialSuggestions) {
                      showCustomDialog(
                        context,
                        confirmButtonLabel: 'Iniciar',
                        onConfirm: AclsRoutes.acls.navigate,
                        title: 'Medidas iniciais',
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 24.h),
                            Text(
                              '1- Chame ajuda!',
                              style: AppTextStyles.bodyNormal,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              '2- Solicite o desfribilador/DEA.',
                              style: AppTextStyles.bodyNormal,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              '3- Inicie a massagem cardíaca.',
                              style: AppTextStyles.bodyNormal,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              '4- Solicite acesso venoso.',
                              style: AppTextStyles.bodyNormal,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              '5- Cheque a glicemia.',
                              style: AppTextStyles.bodyNormal,
                            ),
                            SizedBox(height: 24.h),
                          ],
                        ),
                      );
                    } else {
                      AclsRoutes.acls.navigate();
                    }
                  },
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
