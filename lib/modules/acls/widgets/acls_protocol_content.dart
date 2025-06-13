import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/acls/acls_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/libs/acls/models/acls_step.dart';
import 'package:condutta_med/modules/acls/bloc/acls/acls_cubit.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/libs/acls/models/acls_heart_frequency.dart';
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
                  style: AppTextStyles.bodyNormal
                      .copyWith(color: AppColors.textBlack),
                ),
                SizedBox(height: 12.h),
                _buildActionSection(
                  label: 'Compressão torácica',
                  time: state.compressionsTimerFormatted,
                  value: state.compressionsTimer?.isActive == true
                      ? (state.compressionsTotalTime -
                              state.compressionsTimeLeft) /
                          state.compressionsTotalTime
                      : 0,
                  buttonText: (state.compressionsTimer?.isActive ?? false)
                      ? 'Parar'
                      : 'Iniciar',
                  indicatorColor: state.compressionsTimeLeft <= 15
                      ? AppColors.danger
                      : state.compressionsTimeLeft <= 30
                          ? AppColors.tertiary
                          : AppColors.primary,
                  color: (state.step == AclsStep.massage)
                      ? AppColors.success
                      : AppColors.secondary,
                  onButtonPressed: state.compressionsTimer?.isActive == true
                      ? bloc.stopCompressions
                      : bloc.startCompressions,
                ),
                SizedBox(height: 12.h),
                _buildActionSection(
                  label: 'Adrenalina',
                  time: state.formatTime(state.medicationTimeLeft),
                  value: state.medicationTimer?.isActive == true
                      ? (state.medicationTotalTime - state.medicationTimeLeft) /
                          state.medicationTotalTime
                      : 0,
                  buttonText: 'Administrar',
                  color: (state.step == AclsStep.medication &&
                          !(state.medicationTimer?.isActive ?? false))
                      ? AppColors.success
                      : AppColors.secondary,
                  indicatorColor: AppColors.primary,
                  icon: Icons.medication_outlined,
                  onButtonPressed: bloc.startAdrenaline,
                ),
                SizedBox(height: 12.h),
                const Divider(),
                SizedBox(height: 12.h),
                SolidButton(
                  label: 'Choque',
                  color: (state.step == AclsStep.shock)
                      ? AppColors.success
                      : AppColors.secondary,
                  labelColor: (state.step == AclsStep.shock)
                      ? AppColors.textBlack.withOpacity(.75)
                      : AppColors.textWhite,
                  icon: Icons.bolt,
                  onPressed: bloc.startShock,
                ),
                SizedBox(height: 12.h),
                const Divider(),
                SizedBox(height: 12.h),
                IconNavigationTile(
                  icon: Symbols.monitor_heart,
                  title: 'Ritmo cardíaco',
                  value: state.heartFrequency.toString(),
                  backgroundColor:
                      (state.heartFrequency == AclsHeartFrequency.unknown &&
                              state.totalCompressions >= 1 &&
                              state.compressionsTimer?.isActive == false)
                          ? AppColors.success
                          : null,
                  onTap: AclsRoutes.heartFrequency.navigate,
                ),
                IconNavigationTile(
                  value: 'Medicações',
                  icon: Symbols.pill,
                  onTap: AclsRoutes.medications.navigate,
                ),
                IconNavigationTile(
                  value: 'Eventos',
                  icon: Icons.pending_actions_outlined,
                  onTap: AclsRoutes.events.navigate,
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
                  onPressed: AclsRoutes.finish.navigate,
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
                color: AppColors.grey,
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
          labelColor: color == AppColors.success
              ? AppColors.textBlack.withOpacity(.75)
              : AppColors.textWhite,
          icon: icon,
          onPressed: onButtonPressed,
        ),
      ],
    );
  }
}
