import 'package:flutter/material.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';

class CustomSwitchTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final Function(bool) onChanged;
  const CustomSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      value: value,
      activeColor: AppColors.primary,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.subtitleBold.copyWith(
              color: AppColors.grey,
            ),
          ),
          Visibility(
            visible: subtitle != null,
            child: Text(
              subtitle ?? '',
              style: AppTextStyles.subtitleNormal.copyWith(
                color: AppColors.grey,
              ),
            ),
          ),
        ],
      ),
      onChanged: onChanged,
    );
  }
}
