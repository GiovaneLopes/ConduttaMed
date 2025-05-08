import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:condutta_med/modules/auth/auth_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/auth/bloc/auth_cubit.dart';
import 'package:condutta_med/modules/shared/utils/string_extension.dart';
import 'package:condutta_med/modules/shared/components/default_page.dart';
import 'package:condutta_med/modules/shared/components/solid_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authBloc = Modular.get<AuthCubit>();
  @override
  Widget build(BuildContext context) {
    return DefaultPage.withNoAppbar(
      body: Center(
        child: BlocBuilder<AuthCubit, AuthState>(
            bloc: authBloc,
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  state.status == AuthStatus.loading
                      ? const CircularProgressIndicator()
                      : Text(
                          'Welcome ${Modular.get<AuthCubit>().state.user?.name?.capitalize() ?? 'User'}',
                        ),
                  SizedBox(height: 16.h),
                  if (state.user == null)
                    SolidButton(
                      text: 'Login',
                      enabled: state.status == AuthStatus.loaded,
                      onPressed: AuthRoutes.login.navigate,
                    )
                  else
                    SolidButton(
                      text: 'Logout',
                      enabled: state.status == AuthStatus.loaded,
                      onPressed: authBloc.logout,
                    ),
                ],
              );
            }),
      ),
    );
  }
}
