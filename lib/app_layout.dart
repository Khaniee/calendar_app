import 'package:flutter/material.dart';
import 'package:my_project/utils/color.dart';
import 'package:my_project/utils/fontsize.dart';
import 'package:my_project/widgets/text.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({
    super.key,
    required this.child,
    this.appBar,
    this.title,
    this.appBarColor,
    this.backgroundColor,
    this.textColor,
    this.showAppBar = true,
  });

  final Widget child;
  final AppBar? appBar;
  final String? title;
  final Color? appBarColor;
  final Color? backgroundColor;
  final Color? textColor;
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColor.offWhite,
      appBar: appBar ??
          (showAppBar
              ? AppBar(
                  title: AppText(
                    title ?? "Calendar App",
                    fontSize: AppFontSize.large,
                    color: textColor ?? AppColor.textColor,
                  ),
                  backgroundColor: appBarColor ?? Colors.transparent,
                  foregroundColor: AppColor.textColor,
                  elevation: 0,
                )
              : null),
      body: SafeArea(child: child),
    );
  }
}
