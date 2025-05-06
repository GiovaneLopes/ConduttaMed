import 'package:flutter/material.dart';
import '../../shared/resources/images.dart';
import '../../shared/resources/app_colors.dart';
import '../../shared/components/solid_button.dart';
import '../../shared/resources/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/components/default_page.dart';

class EmailConfirmationPage extends StatelessWidget {
  const EmailConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: 'Confirmação de E-mail',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 80.h,
              height: 80.h,
              child: Image.asset(
                Images.appLogo,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Confira o link de confirmação que enviamos para seu e-mail',
            style: AppTextStyles.subtitleNormal.copyWith(
              color: AppColors.grey,
            ),
          ),
          SizedBox(height: 16.h),
          Image.asset(
            Images.emailConfirmation,
            height: 127.h,
          ),
          SizedBox(height: 16.h),
          SolidButton(
            onPressed: () {},
            text: 'Confirmar',
          ),
        ],
      ),
    );
  }
}
