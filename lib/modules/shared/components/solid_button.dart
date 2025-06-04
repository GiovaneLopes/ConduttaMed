import '../resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';

class SolidButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool enabled;
  final bool loading;
  final Color? color;
  final Color labelColor;
  final IconData? icon;

  const SolidButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.enabled = true,
    this.loading = false,
    this.color = AppColors.secondary,
    this.labelColor = AppColors.textWhite,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled ? color : AppColors.disabled,
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
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: icon != null,
                    child: Icon(
                      icon,
                      color: labelColor,
                    ),
                  ),
                  Text(
                    label,
                    style: AppTextStyles.bodyBold.copyWith(
                      color: labelColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
