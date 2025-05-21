import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/utils/validators.dart';
import 'package:condutta_med/libs/acls/models/acls_medications.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/components/default_page.dart';
import 'package:condutta_med/modules/shared/components/custom_dialog.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';
import 'package:condutta_med/modules/shared/components/custom_text_field.dart';
import 'package:condutta_med/modules/acls/bloc/acls_settings/acls_settings_cubit.dart';

class AclsMedicationsPage extends StatefulWidget {
  const AclsMedicationsPage({super.key});

  @override
  State<AclsMedicationsPage> createState() => _AclsMedicationsPageState();
}

class _AclsMedicationsPageState extends State<AclsMedicationsPage> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<AclsSettingsCubit>();
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final infusionController = TextEditingController();

    return DefaultPage.withBackButton(
      title: 'Medicações',
      body: BlocBuilder<AclsSettingsCubit, AclsSettingsState>(
        bloc: bloc,
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                state.settings.medications.length,
                (item) {
                  final medication = state.settings.medications[item];
                  final isExpanded = expandedIndex == item;
                  return Container(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                medication.name,
                                style: AppTextStyles.bodyNormalSmall.copyWith(
                                  color: AppColors.grey,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                nameController.text = medication.name;
                                infusionController.text = medication.infusion;
                                showCustomDialog(
                                  context,
                                  title: 'Editar medicação',
                                  content: Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        CustomTextFormField(
                                          labelText: 'Nome',
                                          controller: nameController,
                                          validator: AppValidators.validateNome,
                                        ),
                                        CustomTextFormField(
                                          labelText: 'Infusão',
                                          controller: infusionController,
                                          validator: AppValidators.validateNome,
                                        ),
                                      ],
                                    ),
                                  ),
                                  confirmButtonLabel: 'Salvar',
                                  onConfirm: () {
                                    if (formKey.currentState!.validate()) {
                                      bloc.updateSettings(
                                        bloc.state.settings.copyWith(
                                          medications: List.from(
                                              bloc.state.settings.medications)
                                            ..removeAt(item)
                                            ..insert(
                                              item,
                                              AclsMedication(
                                                name: nameController.text,
                                                infusion:
                                                    infusionController.text,
                                              ),
                                            ),
                                        ),
                                      );
                                      nameController.clear();
                                      infusionController.clear();
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
                                title: 'Excluir medicação',
                                subtitle:
                                    'Você tem certeza que deseja excluir essa medicação?',
                                confirmButtonLabel: 'Excluir',
                                onConfirm: () {
                                  bloc.updateSettings(
                                    bloc.state.settings.copyWith(
                                      medications: List.from(
                                          bloc.state.settings.medications)
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
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  expandedIndex = isExpanded ? null : item;
                                });
                              },
                              icon: Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: AppColors.secondary,
                                size: 28.w,
                              ),
                            ),
                          ],
                        ),
                        if (isExpanded)
                          Column(
                            children: [
                              const Divider(),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 7.w),
                                child: Text(
                                  'Infusão: ${medication.infusion}',
                                  textAlign: TextAlign.start,
                                  style: AppTextStyles.bodyNormalSmall.copyWith(
                                    color: AppColors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      actions: IconButton(
        icon: Icon(
          Symbols.add,
          color: AppColors.secondary,
          size: 28.w,
        ),
        onPressed: () {
          nameController.clear();
          infusionController.clear();
          showCustomDialog(
            context,
            title: 'Nova medicação',
            content: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    labelText: 'Nome',
                    controller: nameController,
                    validator: AppValidators.validateNome,
                  ),
                  CustomTextFormField(
                    labelText: 'Infusão',
                    controller: infusionController,
                    validator: AppValidators.validateNome,
                  ),
                ],
              ),
            ),
            confirmButtonLabel: 'Adicionar',
            onConfirm: () {
              if (formKey.currentState!.validate()) {
                bloc.updateSettings(
                  bloc.state.settings.copyWith(
                    medications: [
                      ...bloc.state.settings.medications,
                      AclsMedication(
                        name: nameController.text,
                        infusion: infusionController.text,
                      )
                    ],
                  ),
                );
                Modular.to.pop();
              }
            },
          );
        },
      ),
    );
  }
}
