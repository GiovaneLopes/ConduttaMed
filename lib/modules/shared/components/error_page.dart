import '../resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/resources/images.dart';
import 'package:condutta_med/modules/shared/components/solid_button.dart';
import 'package:condutta_med/modules/shared/components/default_page.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultPage.withNoAppbar(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Images.errorIcon,
            width: 120.w,
          ),
          SizedBox(height: 16.h),
          Text(
            'Ops, tivemos um erro',
            style: AppTextStyles.subtitleBold.copyWith(
              color: AppColors.secondary,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Por favor, tente novamente em instantes.',
            style: AppTextStyles.subtitleNormal.copyWith(
              color: AppColors.grey,
            ),
          ),
          SizedBox(height: 16.h),
          SolidButton(
            label: 'Fechar',
            onPressed: Modular.to.pop,
          ),
        ],
      ),
    );
  }
}
