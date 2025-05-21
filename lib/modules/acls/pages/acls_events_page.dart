import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/utils/validators.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/components/default_page.dart';
import 'package:condutta_med/modules/shared/components/custom_dialog.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';
import 'package:condutta_med/modules/shared/components/custom_text_field.dart';
import 'package:condutta_med/modules/acls/bloc/acls_settings/acls_settings_cubit.dart';

class AclsEventsPage extends StatelessWidget {
  const AclsEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<AclsSettingsCubit>();
    final formKey = GlobalKey<FormState>();
    final controller = TextEditingController();
    return DefaultPage.withBackButton(
      title: 'Eventos',
      body: BlocBuilder<AclsSettingsCubit, AclsSettingsState>(
          bloc: bloc,
          builder: (context, state) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                  state.settings.events.length,
                  (item) => Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                      color: AppColors.textWhite,
                      borderRadius: BorderRadius.circular(12.w),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.grey.withOpacity(.25),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            state.settings.events[item],
                            style: AppTextStyles.bodyNormal.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.text = state.settings.events[item];
                            showCustomDialog(
                              context,
                              title: 'Editar evento',
                              content: Form(
                                key: formKey,
                                child: CustomTextFormField(
                                  labelText: 'Evento',
                                  controller: controller,
                                  validator: AppValidators.validateNome,
                                ),
                              ),
                              confirmButtonLabel: 'Salvar',
                              onConfirm: () {
                                if (formKey.currentState!.validate()) {
                                  bloc.updateSettings(
                                    bloc.state.settings.copyWith(
                                      events:
                                          List.from(bloc.state.settings.events)
                                            ..removeAt(item)
                                            ..insert(item, controller.text),
                                    ),
                                  );
                                  Modular.to.pop();
                                }
                              },
                            );
                          },
                          icon: Icon(
                            Icons.edit_outlined,
                            size: 28.w,
                          ),
                        ),
                        IconButton(
                          onPressed: () => showCustomDialog(
                            context,
                            title: 'Excluir evento',
                            subtitle:
                                'Você tem certeza que deseja excluir esse evento?',
                            confirmButtonLabel: 'Excluir',
                            onConfirm: () {
                              bloc.updateSettings(
                                bloc.state.settings.copyWith(
                                  events: List.from(bloc.state.settings.events)
                                    ..removeAt(item),
                                ),
                              );
                              Modular.to.pop();
                            },
                          ),
                          icon: Icon(
                            Icons.delete_outline,
                            color: AppColors.danger,
                            size: 28.w,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
      actions: IconButton(
          icon: Icon(
            Symbols.add,
            color: AppColors.secondary,
            size: 28.w,
          ),
          onPressed: () {
            controller.clear();
            showCustomDialog(
              context,
              title: 'Novo evento',
              content: Form(
                key: formKey,
                child: CustomTextFormField(
                  labelText: 'Evento',
                  controller: controller,
                  validator: AppValidators.validateNome,
                ),
              ),
              confirmButtonLabel: 'Adicionar',
              onConfirm: () {
                if (formKey.currentState!.validate()) {
                  bloc.updateSettings(
                    bloc.state.settings.copyWith(
                      events: [...bloc.state.settings.events, controller.text],
                    ),
                  );
                  Modular.to.pop();
                }
              },
            );
          }),
    );
  }
}
