import 'package:flutter/material.dart';
import 'package:my_project/app_layout.dart';
import 'package:my_project/utils/color.dart';
import 'package:my_project/utils/fontsize.dart';
import 'package:my_project/widgets/text.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: "",
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              "Settings",
              isBold: true,
              fontSize: AppFontSize.extraLarge,
            ),
            SettingCard(),
          ],
        ),
      ),
    );
  }
}

class SettingCard extends StatelessWidget {
  const SettingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: AppColor.divider, offset: Offset(0, 2), blurRadius: 3)
        ],
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          AppText(
            "Application Version",
          ),
          const Expanded(child: SizedBox()),
          Icon(
            Icons.chevron_right,
            color: AppColor.textColor,
          ),
        ],
      ),
    );
  }
}
