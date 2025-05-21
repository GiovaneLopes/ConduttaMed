import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.w),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          label,
          style: AppTextStyles.bodyBold,
        ),
      ),
    );
  }
}
