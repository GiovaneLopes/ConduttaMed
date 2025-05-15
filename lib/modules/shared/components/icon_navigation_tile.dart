import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';

class IconNavigationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool enabled;
  final VoidCallback onTap;
  const IconNavigationTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
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
        padding: EdgeInsets.all(14.w),
        child: Row(
          children: [
            Icon(
              icon,
              color: enabled ? AppColors.secondary : AppColors.disabled,
              size: 24.w,
            ),
            SizedBox(width: 18.w),
            Text(
              title,
              style: AppTextStyles.subtitleNormal.copyWith(
                color: enabled ? AppColors.grey : AppColors.disabled,
              ),
            ),
            const Expanded(child: SizedBox()),
            Icon(
              Icons.chevron_right,
              color: enabled ? AppColors.grey : AppColors.disabled,
              size: 24.w,
            ),
          ],
        ),
      ),
    );
  }
}
