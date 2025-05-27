import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:condutta_med/modules/acls/acls_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:condutta_med/libs/acls/models/acls_help_item.dart';
import 'package:condutta_med/modules/shared/resources/app_colors.dart';
import 'package:condutta_med/modules/shared/resources/app_text_styles.dart';
import 'package:condutta_med/modules/shared/components/icon_navigation_tile.dart';

class AclsHelpContent extends StatefulWidget {
  const AclsHelpContent({super.key});
  @override
  State<AclsHelpContent> createState() => _AclsHelpContentState();
}

class _AclsHelpContentState extends State<AclsHelpContent> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 24.w, left: 24.w, right: 24.w),
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          IconNavigationTile(
            icon: Symbols.flowchart,
            title: 'ACLS',
            value: 'Visualizar protocolo',
            onTap: AclsRoutes.flow.navigate,
          ),
          ...List.generate(AclsHelpItem.values.length, (item) {
            final isExpanded = expandedIndex == item;
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: AppColors.textWhite,
                borderRadius: BorderRadius.circular(12.w),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.grey.withOpacity(.25),
                    blurRadius: 4,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(AclsHelpItem.values[item].title,
                            style: AppTextStyles.bodyNormal),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            expandedIndex = isExpanded ? null : item;
                          });
                        },
                        icon: Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: AppColors.secondary,
                          size: 28.w,
                        ),
                      ),
                    ],
                  ),
                  if (isExpanded)
                    Column(
                      children: [
                        const Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 7.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: AclsHelpItem.values[item].items
                                .map(
                                  (item) => Padding(
                                    padding: EdgeInsets.only(bottom: 12.h),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item,
                                            style: AppTextStyles.bodyNormalSmall
                                                .copyWith(
                                              color: AppColors.textBlack,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          }).toList(),
        ]),
      ),
    );
  }
}
