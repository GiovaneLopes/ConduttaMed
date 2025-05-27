import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';

class InfoLine extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;
  const InfoLine({
    super.key,
    required this.title,
    required this.value,
    this.valueColor = AppColors.textBlack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.disabled),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.subtitleNormal,
          ),
          Text(
            value,
            style: AppTextStyles.bodyNormalSmall.copyWith(
              color: valueColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
