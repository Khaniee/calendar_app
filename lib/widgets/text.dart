import 'package:flutter/material.dart';
import 'package:my_project/utils/color.dart';
import 'package:my_project/utils/fontsize.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    super.key,
    this.color = AppColor.textColor,
    this.fontSize = AppFontSize.medium,
    this.isBold = false,
  });

  final String data;
  final Color color;
  final double fontSize;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    );
  }
}
