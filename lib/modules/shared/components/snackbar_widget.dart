import 'package:flutter/material.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';

class SnackbarWidget {
  static void mostrar(
    BuildContext context, {
    String? title,
    String? message,
    Color? color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? 'Erro',
              style: AppTextStyles.subtitleBold.copyWith(
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
        backgroundColor: color ?? AppColors.textBlack,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Fechar',
          textColor: AppColors.textWhite,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
