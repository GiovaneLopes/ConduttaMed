import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/acls/acls_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/components/default_page.dart';
import 'package:condutta_med/modules/shared/components/custom_dialog.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';
import 'package:condutta_med/modules/shared/components/snackbar_widget.dart';
import 'package:condutta_med/modules/shared/components/custom_switch_tile.dart';
import 'package:condutta_med/modules/shared/components/icon_navigation_tile.dart';
import 'package:condutta_med/modules/acls/bloc/acls_settings/acls_settings_cubit.dart';

class AclsSettingsPage extends StatefulWidget {
  const AclsSettingsPage({super.key});

  @override
  State<AclsSettingsPage> createState() => _AclsSettingsPageState();
}

class _AclsSettingsPageState extends State<AclsSettingsPage> {
  final AclsSettingsCubit bloc = Modular.get<AclsSettingsCubit>();

  @override
  Widget build(BuildContext context) {
    return DefaultPage.withBackButton(
      title: 'Configurações',
      body: BlocConsumer<AclsSettingsCubit, AclsSettingsState>(
          bloc: bloc,
          listener: (context, state) {
            if (state.status == AclsSettingsStatus.error) {
              SnackbarWidget.mostrar(context,
                  title: state.error?.title, message: state.error?.message);
            }
          },
          builder: (context, state) {
            if (state.status == AclsSettingsStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 28.h),
                Text(
                  'Frequência de compressões',
                  style: AppTextStyles.subtitleNormal.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  height: 33.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primary,
                    ),
                    borderRadius: BorderRadius.circular(6.w),
                  ),
                  child: Row(
                    children: List.generate(state.frequencies.length, (item) {
                      return Flexible(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            bloc.saveSettings(state.settings.copyWith(
                              defaultFrequency: state.frequencies[item],
                            ));
                          }),
                          child: Container(
                            height: 33.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: state.settings.defaultFrequency ==
                                      state.frequencies[item]
                                  ? AppColors.primary
                                  : null,
                              border: Border(
                                right: BorderSide(
                                  color: AppColors.primary,
                                  width: item == state.frequencies.length - 1
                                      ? 0
                                      : 1,
                                ),
                              ),
                            ),
                            child: Text(
                              state.frequencies[item].toString(),
                              textAlign: TextAlign.center,
                              style: AppTextStyles.subtitleNormal
                                  .copyWith(color: AppColors.grey),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Tempo entre medicações',
                  style: AppTextStyles.subtitleNormal.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  height: 33.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primary,
                    ),
                    borderRadius: BorderRadius.circular(6.w),
                  ),
                  child: Row(
                    children: List.generate(state.times.length, (item) {
                      return Flexible(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            bloc.saveSettings(state.settings.copyWith(
                              defaultTime: state.times[item],
                            ));
                          }),
                          child: Container(
                            height: 33.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: state.settings.defaultTime ==
                                      state.times[item]
                                  ? AppColors.primary
                                  : null,
                              border: Border(
                                right: BorderSide(
                                  color: AppColors.primary,
                                  width: item == state.times.length - 1 ? 0 : 1,
                                ),
                              ),
                            ),
                            child: Text(
                              '${state.times[item].toString()} minutos',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.subtitleNormal
                                  .copyWith(color: AppColors.grey),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 12.h),
                IconNavigationTile(
                  icon: Icons.pending_actions_outlined,
                  value: 'Eventos',
                  onTap: AclsRoutes.settingsEvents.navigate,
                ),
                IconNavigationTile(
                  icon: Symbols.pill,
                  value: 'Medicações',
                  onTap: AclsRoutes.settingsMedications.navigate,
                ),
                CustomSwitchTile(
                  value: state.settings.showInitialSuggestions,
                  title: 'Mostrar medidas iniciais',
                  onChanged: (value) {
                    bloc.saveSettings(state.settings.copyWith(
                      showInitialSuggestions: value,
                    ));
                  },
                ),
                SizedBox(height: 12.h),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
                    side: const BorderSide(
                      color: AppColors.secondary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.w),
                    ),
                  ),
                  onPressed: () => showCustomDialog(
                    context,
                    title: 'Resetar configurações',
                    subtitle:
                        'Você tem certeza que deseja resetar as configurações?',
                    confirmButtonLabel: 'Resetar',
                    onConfirm: () {
                      bloc.resetSettings();
                      Modular.to.pop();
                    },
                  ),
                  child: Text(
                    'Resetar configurações',
                    style: AppTextStyles.subtitleNormal.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
