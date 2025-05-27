import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/acls/bloc/acls/acls_cubit.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/components/default_page.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';

class AclsEventsPage extends StatelessWidget {
  const AclsEventsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<AclsCubit>();
    return DefaultPage.withBackButton(
      title: 'Eventos',
      body: BlocBuilder<AclsCubit, AclsState>(
        bloc: bloc,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
              state.settings.events.length,
              (item) => GestureDetector(
                onTap: () {
                  bloc.addEvent(state.settings.events[item]);
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
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.w),
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
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
