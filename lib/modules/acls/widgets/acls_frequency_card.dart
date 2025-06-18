import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/libs/acls/models/acls_heart_frequency.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';

class AclsFrequencyCard extends StatelessWidget {
  final AclsHeartFrequency frequency;
  final VoidCallback? onSelected;
  const AclsFrequencyCard({
    super.key,
    required this.frequency,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.w),
        decoration: BoxDecoration(
            color: AppColors.textWhite,
            borderRadius: BorderRadius.circular(8.w),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 56.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.w),
                  topRight: Radius.circular(8.w),
                ),
                image: DecorationImage(
                  image: AssetImage(
                    frequency.image(),
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    frequency.toString(),
                    style: AppTextStyles.bodyBold,
                  ),
                  Text(
                    frequency.type(),
                    style: AppTextStyles.bodyNormalSmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
