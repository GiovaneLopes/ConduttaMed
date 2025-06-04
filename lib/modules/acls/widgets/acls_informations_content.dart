import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/acls/bloc/acls/acls_cubit.dart';
import 'package:condutta_med/modules/shared/components/info_line.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';

class AclsInformationsContent extends StatelessWidget {
  const AclsInformationsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<AclsCubit>();
    return BlocBuilder<AclsCubit, AclsState>(
      bloc: bloc,
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 16.h, left: 24.w, right: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resumo',
                  style: AppTextStyles.bodyBold.copyWith(color: AppColors.grey),
                ),
                InfoLine(
                  title: 'FCT',
                  value: '${state.fct}%',
                  valueColor: state.fct < 60
                      ? AppColors.danger
                      : state.fct < 80
                          ? AppColors.tertiary
                          : AppColors.success,
                ),
                InfoLine(
                  title: 'Ciclos de compressão',
                  value: state.totalCompressions.toString(),
                ),
                InfoLine(
                  title: 'Choques',
                  value: state.totalShocks.toString(),
                ),
                InfoLine(
                  title: 'Adrenalinas',
                  value: state.totalAdrenalines.toString(),
                ),
                InfoLine(
                  title: 'Medicações',
                  value: state.totalMedications.toString(),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Registros',
                  style: AppTextStyles.bodyBold.copyWith(color: AppColors.grey),
                ),
                ...state.activities.map((activity) {
                  return InfoLine(
                    title: activity.title,
                    value: activity.time,
                  );
                })
              ],
            ),
          ),
        );
      },
    );
  }
}
