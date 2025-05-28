import 'package:condutta_med/libs/acls/models/acls_heart_frequency.dart';
import 'package:condutta_med/libs/acls/models/acls_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/acls/acls_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/acls/bloc/acls/acls_cubit.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/components/solid_button.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';
import 'package:condutta_med/modules/shared/components/custom_switch_tile.dart';
import 'package:condutta_med/modules/shared/components/icon_navigation_tile.dart';

class AclsProtocolContent extends StatefulWidget {
  const AclsProtocolContent({super.key});

  @override
  State<AclsProtocolContent> createState() => _AclsProtocolContentState();
}

class _AclsProtocolContentState extends State<AclsProtocolContent> {
  final bloc = Modular.get<AclsCubit>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: BlocBuilder<AclsCubit, AclsState>(
          bloc: bloc,
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 12.h),
                Text(
                  'Próxima etapa:',
                  style: AppTextStyles.bodyBold
                      .copyWith(color: AppColors.secondary),
                ),
                const SizedBox(height: 5),
                Text(
                  state.step.toString(),
                  style: AppTextStyles.subtitleBold
                      .copyWith(color: AppColors.success),
                ),
                SizedBox(height: 12.h),
                IconNavigationTile(
                  icon: Symbols.monitor_heart,
                  title: 'Ritmo cardíaco',
                  value: state.heartFrequency.toString(),
                  backgroundColor:
                      (state.heartFrequency == AclsHeartFrequency.unknown)
                          ? AppColors.success
                          : null,
                  onTap: AclsRoutes.heartFrequency.navigate,
                ),
                SizedBox(height: 12.h),
                _buildActionSection(
                  label: 'Massagem cardíaca',
                  time: state.formatTime(state.compressionsTime),
                  value: (120 - state.compressionsTime) / 120,
                  buttonText:
                      state.compressionsTime < 120 ? 'Parar' : 'Iniciar',
                  indicatorColor: state.compressionsTime <= 15
                      ? AppColors.danger
                      : state.compressionsTime <= 30
                          ? AppColors.tertiary
                          : AppColors.success,
                  color: (state.step == AclsStep.massage)
                      ? AppColors.success
                      : AppColors.secondary,
                  onButtonPressed: bloc.startCompressions,
                ),
                SizedBox(height: 12.h),
                _buildActionSection(
                  label: 'Adrenalina',
                  time: '00:00',
                  value: 0,
                  buttonText: 'Administrar',
                  color: (state.step == AclsStep.medication)
                      ? AppColors.success
                      : AppColors.secondary,
                  indicatorColor: AppColors.success,
                  icon: Icons.medication_outlined,
                  onButtonPressed: () {},
                ),
                SizedBox(height: 12.h),
                const Divider(),
                SizedBox(height: 12.h),
                SolidButton(
                  label: 'Choque',
                  color: (state.step == AclsStep.shock)
                      ? AppColors.success
                      : AppColors.secondary,
                  icon: Icons.bolt,
                  onPressed: () {},
                ),
                SizedBox(height: 12.h),
                IconNavigationTile(
                  value: 'Eventos',
                  icon: Icons.pending_actions_outlined,
                  onTap: AclsRoutes.events.navigate,
                ),
                IconNavigationTile(
                  value: 'Medicações',
                  icon: Symbols.pill,
                  onTap: AclsRoutes.medications.navigate,
                ),
                const Divider(),
                CustomSwitchTile(
                  value: state.advancedAirway,
                  title: 'Via aérea avançada?',
                  subtitle: state.advancedAirway
                      ? 'Compressões: contínuas\nVentilações: 1 a cada 6 segundos'
                      : 'Compressões: 30\nVentilações: 2',
                  onChanged: (value) {
                    bloc.advancedAirwayChanged();
                  },
                ),
                SizedBox(height: 24.h),
                SolidButton(
                  label: 'Encerrar RCP',
                  onPressed: () {},
                ),
                SizedBox(height: 24.h),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionSection({
    required String label,
    required String time,
    required String buttonText,
    required VoidCallback onButtonPressed,
    required Color color,
    required Color indicatorColor,
    required double? value,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyles.subtitleBold.copyWith(
                color: AppColors.grey,
              ),
            ),
            Text(
              time,
              style: AppTextStyles.bodyBold.copyWith(
                color: (value ?? 0) > 0 ? AppColors.grey : Colors.transparent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        LinearProgressIndicator(
            value: value,
            minHeight: 10.h,
            backgroundColor: Colors.grey[300],
            borderRadius: BorderRadius.circular(10.h),
            color: indicatorColor),
        const SizedBox(height: 10),
        SolidButton(
          label: buttonText,
          color: color,
          icon: icon,
          onPressed: onButtonPressed,
        ),
      ],
    );
  }
}
