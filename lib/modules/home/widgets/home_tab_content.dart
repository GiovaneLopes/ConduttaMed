import 'package:flutter/material.dart';
import 'package:condutta_med/modules/auth/auth_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/modules/home/models/home_item.dart';
import 'package:condutta_med/modules/shared/resources/images.dart';
import 'package:condutta_med/modules/home/widgets/rounded_card.dart';
import 'package:condutta_med/modules/home/models/home_item_type.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';

class HomeTabContent extends StatefulWidget {
  const HomeTabContent({super.key});
  @override
  State<HomeTabContent> createState() => _HomeTabContentState();
}

class _HomeTabContentState extends State<HomeTabContent> {
  final TextEditingController _searchController = TextEditingController();
  final items = <HomeItem>[
    HomeItem(
      title: 'Ressuscitação Cardiopulmonar (ACLS)',
      type: HomeItemType.emphasys,
      route: AuthRoutes.login,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          color: AppColors.secondary,
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    Images.appLogo,
                    height: 42.w,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Condutta Med',
                    style: AppTextStyles.bodyBold.copyWith(
                      color: AppColors.textWhite,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 32.w,
                child: TextField(
                  cursorHeight: 16.h,
                  controller: _searchController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 16.w),
                    hintText: 'Pesquisar',
                    hintStyle: AppTextStyles.subtitleNormal,
                    suffixIcon: InkWell(
                      child: Icon(
                        _searchController.text.isEmpty
                            ? Icons.search
                            : Icons.close,
                        color: AppColors.secondary,
                        size: 24.w,
                      ),
                      onTap: () => setState(
                        () {
                          _searchController.clear();
                        },
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: AppColors.textWhite,
                      ),
                    ),
                  ),
                  onChanged: (value) => setState(
                    () {
                      _searchController.text = value;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            color: Colors.white,
            child: SingleChildScrollView(
              child: _searchController.text.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24.h),
                        Text(
                          'Destaque',
                          style: AppTextStyles.subtitleNormal.copyWith(
                            color: AppColors.textBlack,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          spacing: 8.h,
                          children: items.map((item) {
                            if (item.type == HomeItemType.emphasys) {
                              return RoundedCard(
                                title: item.title,
                                type: item.type,
                                onPressed: item.route.navigate,
                              );
                            }
                            return Container();
                          }).toList(),
                        ),
                      ],
                    )
                  : Column(
                      children: items.map((item) {
                        if (item.title
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase())) {
                          return InkWell(
                            onTap: item.route.navigate,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.disabled,
                                  ),
                                ),
                              ),
                              child: Text(
                                item.title,
                                style: AppTextStyles.subtitleNormal
                                    .copyWith(color: AppColors.grey),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }).toList(),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
