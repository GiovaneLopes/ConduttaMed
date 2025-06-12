import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/components/solid_button.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';
import 'package:condutta_med/modules/shared/components/custom_text_button.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final String? subtitle;
  final bool isCancelable;
  final String confirmButtonLabel;
  final Widget? content;
  final void Function() onConfirm;

  const CustomDialog({
    super.key,
    required this.title,
    required this.confirmButtonLabel,
    required this.onConfirm,
    this.isCancelable = true,
    this.subtitle,
    this.content,
  });
  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(24.w),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style:
                  AppTextStyles.bodyBold.copyWith(color: AppColors.secondary),
            ),
            SizedBox(height: 8.h),
            Visibility(
              visible: widget.subtitle != null,
              child: Text(
                widget.subtitle ?? '',
                style: AppTextStyles.subtitleNormal,
              ),
            ),
            Visibility(
              visible: widget.subtitle != null,
              child: SizedBox(height: 8.h),
            ),
            widget.content ?? const SizedBox.shrink(),
            SolidButton(
              onPressed: widget.onConfirm,
              label: widget.confirmButtonLabel,
            ),
            SizedBox(height: 8.h),
            Visibility(
              visible: widget.isCancelable,
              child: CustomTextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                label: 'Cancelar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showCustomDialog(
  BuildContext context, {
  required String title,
  required String confirmButtonLabel,
  bool isCancelable = true,
  String? subtitle,
  Widget? content,
  required void Function() onConfirm,
}) async {
  await showDialog(
    context: context,
    builder: (context) => CustomDialog(
      title: title,
      confirmButtonLabel: confirmButtonLabel,
      onConfirm: onConfirm,
      isCancelable: isCancelable,
      content: content,
      subtitle: subtitle,
    ),
  );
}
