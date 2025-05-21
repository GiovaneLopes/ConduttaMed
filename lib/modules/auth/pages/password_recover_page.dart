import 'package:flutter/material.dart';
import '../../shared/resources/images.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/resources/app_colors.dart';
import '../../shared/components/solid_button.dart';
import '../../shared/resources/app_text_styles.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/components/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/auth/bloc/auth_cubit.dart';
import 'package:condutta_med/modules/shared/utils/validators.dart';
import 'package:condutta_med/modules/shared/components/default_page.dart';
import 'package:condutta_med/modules/shared/components/snackbar_widget.dart';

class PasswordRecoverPage extends StatefulWidget {
  const PasswordRecoverPage({super.key});

  @override
  State<PasswordRecoverPage> createState() => _PasswordRecoverPageState();
}

class _PasswordRecoverPageState extends State<PasswordRecoverPage> {
  final bloc = Modular.get<AuthCubit>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  void _send() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      bloc.recoverPassword(_emailController.text);
    }
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
          BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state.status == AuthStatus.error) {
                  SnackbarWidget.mostrar(context,
                      title: state.error?.title, message: state.error?.message);
                } else if (state.status == AuthStatus.loaded) {
                  SnackbarWidget.mostrar(
                    context,
                    title: 'E-mail enviado',
                    type: SnackbarWidgetType.success,
                    message:
                        'Enviamos um link de recuperação de senha para seu e-mail.',
                  );
                }
              },
              bloc: bloc,
              builder: (context, state) {
                return SolidButton(
                  loading: state.status == AuthStatus.loading,
                  onPressed: _send,
                  label: 'Enviar',
                );
              }),
        ],
      ),
    );
  }
}
