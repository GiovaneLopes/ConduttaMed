import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';

class IconNavigationTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String? title;
  final Color? backgroundColor;
  final bool enabled;
  final VoidCallback onTap;
  const IconNavigationTile({
    super.key,
    required this.icon,
    required this.value,
    required this.onTap,
    this.backgroundColor,
    this.title,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.textWhite,
          borderRadius: BorderRadius.circular(12.w),
          boxShadow: [
            BoxShadow(
              color: backgroundColor != null
                  ? AppColors.textWhite
                  : AppColors.grey.withOpacity(.25),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(14.w),
        child: Row(
          children: [
            Icon(
              icon,
              color: enabled ? AppColors.secondary : AppColors.disabled,
              size: 24.w,
            ),
            SizedBox(width: 18.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: title != null,
                  child: Text(
                    title ?? '',
                    style: AppTextStyles.subtitleBold.copyWith(
                      color: backgroundColor != null
                          ? AppColors.textWhite
                          : AppColors.grey,
                    ),
                  ),
                ),
                Text(
                  value,
                  style: AppTextStyles.subtitleNormal.copyWith(
                    color: enabled ? AppColors.grey : AppColors.disabled,
                  ),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Icon(
              Icons.chevron_right,
              color: AppColors.secondary,
              size: 24.w,
            ),
          ],
        ),
      ),
    );
  }
}
