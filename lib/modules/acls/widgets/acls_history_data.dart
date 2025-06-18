import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/resources/images.dart';
import 'package:condutta_med/modules/shared/components/info_line.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';
import 'package:condutta_med/modules/acls/bloc/acls_history/acls_history_cubit.dart';

class AclsHistoryData extends StatelessWidget {
  const AclsHistoryData({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<AclsHistoryCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.w),
          decoration: const BoxDecoration(color: AppColors.secondary),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'ACLS: ${bloc.state.getFormattedDateWithTime(bloc.state.selected?.date ?? DateTime.now())}',
                  style: AppTextStyles.subtitleBold
                      .copyWith(color: AppColors.textWhite)),
              Image.asset(Images.appLogo, width: 50, height: 50),
            ],
          ),
        ),
        SizedBox(height: 13.h),
        Text(
          'Resumo',
          style: AppTextStyles.titleBold.copyWith(color: AppColors.grey),
        ),
        InfoLine(
          title: 'Tempo total',
          value: bloc.state.formatTime(
            (bloc.state.selected?.duration ?? 0),
          ),
        ),
        InfoLine(
          title: 'FCT',
          value: '${bloc.state.selected?.fct ?? 0}%',
        ),
        InfoLine(
          title: 'Ciclos de compressão',
          value: bloc.state.selected?.totalCompressions.toString() ?? '',
        ),
        InfoLine(
          title: 'Choques',
          value: bloc.state.selected?.totalShocks.toString() ?? '',
        ),
        InfoLine(
          title: 'Adrenalinas',
          value: bloc.state.selected?.totalAdrenalines.toString() ?? '',
        ),
        InfoLine(
          title: 'Medicações',
          value: bloc.state.selected?.totalMedications.toString() ?? '',
        ),
        InfoLine(
          title: 'Tempo total de compressão',
          value: bloc.state
              .formatTime((bloc.state.selected?.totalCompressionsTime ?? 0)),
        ),
        SizedBox(height: 24.h),
        Text(
          'Registros',
          style: AppTextStyles.titleBold.copyWith(color: AppColors.grey),
        ),
        ...bloc.state.selected!.activities.map((activity) {
          return InfoLine(
            title: activity.title,
            value: activity.time,
          );
        })
      ],
    );
  }
}
