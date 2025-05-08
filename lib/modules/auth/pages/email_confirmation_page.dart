import 'package:flutter/material.dart';
import '../../shared/resources/images.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/resources/app_colors.dart';
import '../../shared/components/solid_button.dart';
import '../../shared/resources/app_text_styles.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/auth/bloc/auth_cubit.dart';
import 'package:condutta_med/modules/shared/components/default_page.dart';
import 'package:condutta_med/modules/shared/components/snackbar_widget.dart';

class EmailConfirmationPage extends StatelessWidget {
  const EmailConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<AuthCubit>();
    return DefaultPage(
      title: 'Confirmação de E-mail',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
            'Confira o link de confirmação que enviamos para seu e-mail',
            style: AppTextStyles.subtitleNormal.copyWith(
              color: AppColors.grey,
            ),
          ),
          SizedBox(height: 16.h),
          Image.asset(
            Images.emailConfirmation,
            height: 127.h,
          ),
          SizedBox(height: 16.h),
          BlocConsumer<AuthCubit, AuthState>(
            bloc: bloc,
            listener: (context, state) {
              if (state.status == AuthStatus.error) {
                SnackbarWidget.mostrar(context,
                    title: state.error?.title, message: state.error?.message);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  SolidButton(
                    onPressed: bloc.verifyEmail,
                    text: 'Confirmar',
                  ),
                  SizedBox(height: 16.h),
                  SolidButton(
                    onPressed: bloc.sendConfirmationEmail,
                    text: 'Enviar novamente',
                  ),
                  SizedBox(height: 16.h),
                  Visibility(
                    visible: state.status == AuthStatus.loading,
                    child: const CircularProgressIndicator(
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
