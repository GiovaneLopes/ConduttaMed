import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _currentIndex == 0 ? AppColors.secondary : Colors.white,
      body: SafeArea(
        child: _currentIndex == 0
            ? const HomeTabContent()
            : const ProfileTabContent(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (value) => setState(() {
          _currentIndex = value;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              FeatherIcons.home,
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
  }
}
