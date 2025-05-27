import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';

enum SnackbarWidgetType {
  error,
  warning,
  success;

  Color color() {
    switch (this) {
      case SnackbarWidgetType.error:
        return AppColors.danger;
      case SnackbarWidgetType.warning:
        return AppColors.tertiary;
      case SnackbarWidgetType.success:
        return AppColors.success;
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
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          margin: EdgeInsets.all(16.w),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.w),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      title ?? 'Erro',
                      textAlign: TextAlign.start,
                      style: AppTextStyles.bodyBold.copyWith(
                        color: type == SnackbarWidgetType.error
                            ? AppColors.textWhite
                            : AppColors.textBlack,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed:
                        ScaffoldMessenger.of(context).hideCurrentSnackBar,
                    icon: Icon(
                      Icons.close,
                      color: type == SnackbarWidgetType.error
                          ? AppColors.textWhite
                          : AppColors.textBlack,
                    ),
                  ),
                ],
              ),
              Text(
                message ?? 'Tente novamente em instantes.',
                style: AppTextStyles.bodyNormalSmall.copyWith(
                  color: type == SnackbarWidgetType.error
                      ? AppColors.textWhite
                      : AppColors.textBlack,
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
