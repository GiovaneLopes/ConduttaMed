import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/home/bloc/home_cubit.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/home/widgets/home_tab_content.dart';
import 'package:condutta_med/modules/home/widgets/profile_tab_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = Modular.get<HomeCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
              state.currentTab == 0 ? AppColors.secondary : Colors.white,
          body: SafeArea(
            child: state.currentTab == 0
                ? const HomeTabContent()
                : const ProfileTabContent(),
          ),
          bottomNavigationBar: CupertinoTabBar(
            backgroundColor: Colors.white,
            currentIndex: state.currentTab,
            onTap: (value) => setState(() {
              bloc.contentUpdated(value);
            }),
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Symbols.home,
                  size: 24.w,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FeatherIcons.menu,
                  size: 24.w,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
