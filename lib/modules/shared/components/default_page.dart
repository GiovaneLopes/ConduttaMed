import '../resources/app_colors.dart';
import 'package:flutter/material.dart';
import '../resources/app_text_styles.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultPage extends StatelessWidget {
  final String? title;
  final Widget? body;
  final Widget? actions;
  final bool leading;
  final bool closeButton;
  final bool appBar;
  final bool centerPage;
  final VoidCallback? onBack;
  const DefaultPage({
    super.key,
    this.title = '',
    required this.body,
    this.actions,
    this.leading = false,
    this.closeButton = false,
    this.appBar = true,
    this.centerPage = false,
    this.onBack,
  });

  static withCloseButton({
    String? title,
    Widget? body,
  }) {
    return DefaultPage(
      title: title,
      body: body,
      leading: false,
      closeButton: true,
    );
  }

  static withBackButton({
    String? title,
    Widget? body,
    Widget? actions,
    VoidCallback? onBack,
  }) {
    return DefaultPage(
      title: title,
      body: body,
      actions: actions,
      leading: true,
      onBack: onBack,
    );
  }

  static withNoAppbar({
    Widget? body,
    bool? centerPage,
  }) {
    return DefaultPage(
      body: body,
      leading: true,
      appBar: false,
      centerPage: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar
          ? AppBar(
              title: Text(
                title ?? '',
                textAlign: TextAlign.center,
                style:
                    AppTextStyles.bodyBold.copyWith(color: AppColors.secondary),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: leading
                  ? IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.secondary,
                      ),
                      onPressed: onBack ?? Modular.to.pop,
                    )
                  : null,
              actions: closeButton
                  ? [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.secondary,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ]
                  : [actions ?? const SizedBox.shrink()],
            )
          : null,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: centerPage ? Center(child: body) : body,
            ),
          );
        },
      ),
    );
  }
}
