import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';

enum SnackbarWidgetType {
  error,
  success;

  Color color() {
    switch (this) {
      case SnackbarWidgetType.error:
        return AppColors.danger;
      case SnackbarWidgetType.success:
        return AppColors.secondary;
    }
  }

  IconData icon() {
    switch (this) {
      case SnackbarWidgetType.error:
        return Icons.error_outline;
      default:
        return Icons.info_outline;
    }
  }
}

class SnackbarWidget {
  static void mostrar(
    BuildContext context, {
    String? title,
    String? message,
    SnackbarWidgetType? type = SnackbarWidgetType.error,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.all(15.w),
        behavior: SnackBarBehavior.floating,
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              type?.icon(),
              color: AppColors.textWhite,
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? 'Erro',
                    style: AppTextStyles.bodyBold.copyWith(
                      color: AppColors.textWhite,
                    ),
                  ),
                  Text(
                    message ?? 'Tente novamente em instantes.',
                    style: AppTextStyles.subtitleNormal.copyWith(
                      color: AppColors.textWhite,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: type?.color(),
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
