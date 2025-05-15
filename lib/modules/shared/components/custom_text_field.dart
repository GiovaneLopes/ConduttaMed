import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Function()? onTap;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.inputFormatters,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final focus = FocusNode();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        focusNode: focus,
        controller: controller,
        cursorColor: AppColors.secondary,
        readOnly: readOnly,
        onTap: onTap,
        style: TextStyle(
          color: enabled ? AppColors.textBlack : AppColors.grey,
        ),
        decoration: InputDecoration(
          fillColor: enabled
              ? AppColors.textWhite
              : AppColors.disabled.withOpacity(.25),
          filled: true,
          focusColor: AppColors.secondary,
          labelText: labelText,
          labelStyle: const TextStyle(color: AppColors.secondary),
          errorMaxLines: 2,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.disabled,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.secondary,
            ),
          ),
          suffixIcon: enabled
              ? null
              : const Icon(
                  Icons.lock_outline,
                  color: AppColors.grey,
                ),
        ),
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
      ),
    );
  }
}
