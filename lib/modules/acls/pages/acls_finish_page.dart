import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/acls/acls_routes.dart';
import 'package:condutta_med/modules/acls/bloc/acls/acls_cubit.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/components/default_page.dart';
import 'package:condutta_med/modules/shared/components/custom_dialog.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';
import 'package:condutta_med/modules/shared/components/icon_navigation_tile.dart';

class AclsFinishPage extends StatelessWidget {
  const AclsFinishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultPage.withBackButton(
      title: 'Encerrar RCP',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selecione o desfecho da RCP',
            style: AppTextStyles.subtitleNormal.copyWith(
              color: AppColors.grey,
            ),
          ),
          SizedBox(height: 12.h),
          IconNavigationTile(
            icon: Symbols.circle,
            value: 'Retorno à circulação espontânea',
            onTap: () {
              showCustomDialog(
                context,
                confirmButtonLabel: 'Finalizar',
                onConfirm: () {
                  Modular.get<AclsCubit>().dispose();
                  Modular.to
                      .popUntil(ModalRoute.withName(AclsRoutes.initial.path));
                },
                title: 'Cuidados pós PCR',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    Text(
                      '1- Manejo da via aérea.',
                      style: AppTextStyles.bodyNormal,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      '2- Controle dos parâmetros respiratórios.',
                      style: AppTextStyles.bodyNormal,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      '3- Controle dos parâmetros hemodinâmicos.',
                      style: AppTextStyles.bodyNormal,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      '4- Controle direcionado de temperatura.',
                      style: AppTextStyles.bodyNormal,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      '5- Solicitar ECG de 12 derivações.',
                      style: AppTextStyles.bodyNormal,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      '6- Solicitar vaga em unidade de terapia intensiva.',
                      style: AppTextStyles.bodyNormal,
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              );
            },
          ),
          IconNavigationTile(
            icon: Symbols.circle,
            value: 'Óbito',
            onTap: () {
              Modular.get<AclsCubit>().dispose();
              Modular.to.popUntil(ModalRoute.withName(AclsRoutes.initial.path));
            },
          ),
        ],
      ),
    );
  }
}
