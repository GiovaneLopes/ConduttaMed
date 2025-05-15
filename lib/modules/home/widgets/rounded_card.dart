import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/home/models/home_item_type.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';

class RoundedCard extends StatelessWidget {
  final String title;
  final HomeItemType type;
  final VoidCallback onPressed;

  const RoundedCard({
    super.key,
    required this.title,
    required this.type,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding:  EdgeInsets.all(12.w),
        margin: EdgeInsets.only(bottom: 22.w,left: 5.w,right: 5.w),
        width: (MediaQuery.of(context).size.width - 80.w) / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.textWhite,
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                type.icon,
                size: 20,
                color: AppColors.secondary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: AppTextStyles.subtitleNormal.copyWith(
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
