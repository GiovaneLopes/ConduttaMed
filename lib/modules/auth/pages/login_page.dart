import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/default_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/auth/auth_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/auth/bloc/auth_cubit.dart';
import 'package:condutta_med/modules/shared/utils/validators.dart';
import 'package:condutta_med/modules/shared/resources/images.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/components/solid_button.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';
import 'package:condutta_med/modules/shared/components/snackbar_widget.dart';
import 'package:condutta_med/modules/shared/components/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final bloc = Modular.get<AuthCubit>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void enviar() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      bloc.login(_emailController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPage.withCloseButton(
      title: 'Login',
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
              'Insira seu e-mail e senha para fazer login',
              style: AppTextStyles.subtitleNormal.copyWith(
                color: AppColors.grey,
              ),
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: AppValidators.validateEmail,
              labelText: 'E-mail',
            ),
            CustomTextFormField(
              controller: _passwordController,
              obscureText: true,
              validator: AppValidators.validateLoginSenha,
              labelText: 'Senha',
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: AuthRoutes.passwordRecover.navigate,
                style: TextButton.styleFrom(padding: const EdgeInsets.all(8)),
                child: Text(
                  'Esqueci a senha',
                  style: AppTextStyles.subtitleBold.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ),
            BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state.status == AuthStatus.error) {
                    SnackbarWidget.mostrar(context,
                        title: state.error?.title,
                        message: state.error?.message);
                  }
                },
                bloc: bloc,
                builder: (context, state) {
                  return SolidButton(
                    loading: state.status == AuthStatus.loading,
                    onPressed: enviar,
                    text: 'Entrar',
                  );
                }),
            SizedBox(height: 16.h),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Ainda não tem cadastro?'),
                TextButton(
                  onPressed: AuthRoutes.registration.navigate,
                  child: Text(
                    'Cadastre-se',
                    style: AppTextStyles.subtitleBold
                        .copyWith(color: AppColors.secondary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
