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
        return Padding(
          padding: EdgeInsets.only(top: 16.h, left: 24.w, right: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Resumo',
                style: AppTextStyles.bodyBold.copyWith(color: AppColors.grey),
              ),
              const InfoLine(
                title: 'FCT',
                value: '2%',
                valueColor: AppColors.danger,
              ),
              const InfoLine(
                title: 'Ciclos de compressão',
                value: '2',
              ),
              const InfoLine(
                title: 'Choques',
                value: '1',
              ),
              const InfoLine(
                title: 'Adrenalinas',
                value: '2',
              ),
              const InfoLine(
                title: 'Medicações',
                value: '5',
              ),
              SizedBox(height: 24.h),
              Text(
                'Registros',
                style: AppTextStyles.bodyBold.copyWith(color: AppColors.grey),
              ),
              const InfoLine(
                title: 'Fibrilação ventricular',
                value: '00:56',
              ),
              const InfoLine(
                title: 'Ciclo massagem 1',
                value: '00:58',
              ),
              const InfoLine(
                title: 'Via aérea Avançada Disponível',
                value: '01:45',
              ),
              const InfoLine(
                title: 'Adrenalina 1',
                value: '01:59',
              ),
            ],
          ),
        );
      },
    );
  }
}
