import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/acls/bloc/acls/acls_cubit.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/components/default_page.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';

class AclsMedicationsPage extends StatefulWidget {
  const AclsMedicationsPage({super.key});

  @override
  State<AclsMedicationsPage> createState() => _AclsMedicationsPageState();
}

class _AclsMedicationsPageState extends State<AclsMedicationsPage> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<AclsCubit>();

    return DefaultPage.withBackButton(
      title: 'Medicações',
      body: BlocBuilder<AclsCubit, AclsState>(
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
                  return GestureDetector(
                    onTap: () {
                      bloc.addMedication(state.settings.medications[item]);
                      Modular.to.pop();
                    },
                    child: Container(
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
                                  style: AppTextStyles.bodyBold.copyWith(
                                    color: AppColors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 7.w),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Infusão: ${medication.infusion}',
                                    textAlign: TextAlign.start,
                                    style:
                                        AppTextStyles.bodyNormalSmall.copyWith(
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
