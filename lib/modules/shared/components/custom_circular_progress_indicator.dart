import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final Color color;
  final double size;

  const CustomCircularProgressIndicator({
    super.key,
    this.color = AppColors.textWhite,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size.w,
        width: size.w,
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
