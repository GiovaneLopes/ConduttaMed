import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/auth/auth_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/auth/bloc/auth_cubit.dart';
import 'package:condutta_med/modules/profile/profile_routes.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:condutta_med/modules/shared/resources/images.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';
import 'package:condutta_med/modules/shared/components/icon_navigation_tile.dart';

class ProfileTabContent extends StatelessWidget {
  const ProfileTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<AuthCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: bloc.state.user == null
                          ? AuthRoutes.login.navigate
                          : null,
                      child: Text(
                        bloc.state.user != null
                            ? 'Olá, ${bloc.state.user?.name?.split(' ').first}'
                            : 'Entrar / Cadastrar',
                        style: AppTextStyles.bodyBold.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                    Image.asset(
                      Images.appLogo,
                      width: 42.w,
                      height: 42.w,
                    ),
                  ],
                ),
                SizedBox(height: 28.h),
                IconNavigationTile(
                  icon: FeatherIcons.edit,
                  title: 'Meus dados',
                  enabled: bloc.state.user != null,
                  onTap: ProfileRoutes.profile.navigate,
                ),
                IconNavigationTile(
                  icon: FeatherIcons.logOut,
                  title: 'Sair',
                  enabled: bloc.state.user != null,
                  onTap: bloc.logout,
                ),
              ],
            );
          }),
    );
  }
}
