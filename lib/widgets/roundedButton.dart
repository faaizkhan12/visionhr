import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../utils/colors.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final bool isLoading;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
    this.textColor,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w400,
    this.width,
    this.height,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading
          ? null
          : () {
        HapticFeedback.heavyImpact();
        onTap();
      },
      child: Container(
        height: height ?? Get.height * 0.058,
        width: width ?? Get.height * 0.38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: color,
          border: color == null ? Border.all(color: AppColors.orange) : null,
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
              : Text(
            text,
            style: TextStyle(
              color: textColor ?? AppColors.txtcolr,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
