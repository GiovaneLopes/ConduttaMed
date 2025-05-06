import 'package:flutter/material.dart';
import '../../shared/resources/images.dart';
import '../../shared/resources/app_colors.dart';
import '../../shared/components/solid_button.dart';
import '../../shared/resources/app_text_styles.dart';
import '../../shared/components/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/shared/utils/validators.dart';
import 'package:condutta_med/modules/shared/components/default_page.dart';

class PasswordRecoverPage extends StatefulWidget {
  const PasswordRecoverPage({super.key});

  @override
  State<PasswordRecoverPage> createState() => _PasswordRecoverPageState();
}

class _PasswordRecoverPageState extends State<PasswordRecoverPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  void _send() {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPage.withBackButton(
      title: 'Recuperação de senha',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              width: 80.h,
              height: 80.h,
              child: Image.asset(
                Images.appLogo,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Insira seu e-mail de cadastro para recuperar a senha',
            style: AppTextStyles.subtitleNormal.copyWith(
              color: AppColors.grey,
            ),
          ),
          SizedBox(height: 12.h),
          Form(
            key: _formKey,
            child: CustomTextFormField(
              controller: _emailController,
              validator: AppValidators.validateEmail,
              keyboardType: TextInputType.emailAddress,
              labelText: 'E-mail',
            ),
          ),
          SizedBox(height: 16.h),
          SolidButton(
            onPressed: _send,
            text: 'Enviar',
          ),
        ],
      ),
    );
  }
}
