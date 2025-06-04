import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/auth/auth_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/auth/bloc/auth_cubit.dart';
import 'package:condutta_med/modules/profile/profile_routes.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:condutta_med/modules/shared/utils/validators.dart';
import 'package:condutta_med/modules/shared/resources/images.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/components/solid_button.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';
import 'package:condutta_med/modules/shared/components/custom_text_field.dart';
import 'package:condutta_med/modules/shared/components/icon_navigation_tile.dart';
import 'package:condutta_med/modules/shared/components/custom_circular_progress_indicator.dart';

class ProfileTabContent extends StatelessWidget {
  const ProfileTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<AuthCubit>();
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    void enviar() {
      FocusManager.instance.primaryFocus?.unfocus();
      if (formKey.currentState!.validate()) {
        bloc.login(emailController.text, passwordController.text);
      }
    }

    return BlocBuilder<AuthCubit, AuthState>(
        bloc: bloc,
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Visibility(
                  visible: bloc.state.user != null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Olá, ${bloc.state.user?.name?.split(' ').first}',
                        style: AppTextStyles.bodyBold.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                      Image.asset(
                        Images.appLogo,
                        width: 42.w,
                        height: 42.w,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: bloc.state.user != null,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 28.h),
                        IconNavigationTile(
                          icon: FeatherIcons.edit,
                          value: 'Meus dados',
                          enabled: bloc.state.user != null,
                          onTap: ProfileRoutes.profile.navigate,
                        ),
                        IconNavigationTile(
                          icon: FeatherIcons.logOut,
                          value: 'Sair',
                          enabled: bloc.state.user != null,
                          onTap: bloc.logout,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Visibility(
                    visible: state.user == null,
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Images.appLogo,
                            width: 68.w,
                            height: 68.w,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'Condutta Med',
                            style: AppTextStyles.bodyBold.copyWith(
                              color: AppColors.secondary,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'Insira seu e-mail e senha para fazer login',
                            style: AppTextStyles.subtitleNormal.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          CustomTextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: AppValidators.validateEmail,
                            labelText: 'E-mail',
                          ),
                          CustomTextFormField(
                            controller: passwordController,
                            obscureText: true,
                            validator: AppValidators.validateLoginSenha,
                            labelText: 'Senha',
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: AuthRoutes.passwordRecover.navigate,
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(8)),
                              child: Text(
                                'Esqueci a senha',
                                style: AppTextStyles.subtitleBold.copyWith(
                                  color: AppColors.secondary,
                                ),
                              ),
                            ),
                          ),
                          SolidButton(
                            loading: state.status == AuthStatus.loading,
                            onPressed: enviar,
                            label: 'Entrar',
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              const Flexible(child: Divider()),
                              const SizedBox(width: 8),
                              Text(
                                'OU',
                                style: AppTextStyles.bodyNormal
                                    .copyWith(color: AppColors.grey),
                              ),
                              const SizedBox(width: 8),
                              const Flexible(child: Divider()),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: bloc.googleAuthentication,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  width: 60.w,
                                  height: 60.w,
                                  child: state.status ==
                                          AuthStatus.authenticating
                                      ? const CustomCircularProgressIndicator(
                                          color: AppColors.secondary)
                                      : Image.asset(Images.gmailLogo),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              GestureDetector(
                                onTap: bloc.appleRegister,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  width: 60.w,
                                  height: 60.w,
                                  child: Image.asset(Images.appStoreLogo),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 18.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Não tem conta?',
                                style: AppTextStyles.subtitleNormal,
                              ),
                              SizedBox(width: 8.h),
                              GestureDetector(
                                onTap: AuthRoutes.registration.navigate,
                                child: Text('Cadastre-se agora!',
                                    style: AppTextStyles.subtitleBold.copyWith(
                                      color: AppColors.secondary,
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
