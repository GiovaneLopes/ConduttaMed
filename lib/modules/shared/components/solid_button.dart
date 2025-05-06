import '../resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';

class SolidButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool loading;

  const SolidButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.w),
          ),
        ),
        child: loading
            ? SizedBox(
                width: 16.w,
                height: 16.w,
                child: const CircularProgressIndicator(
                  color: AppColors.textWhite,
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: AppTextStyles.bodyBold.copyWith(
                  color: AppColors.textWhite,
                ),
              ),
      ),
    );
  }
}
