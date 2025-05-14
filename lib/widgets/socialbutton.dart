import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visionhr/widgets/reusetext.dart';

import '../utils/colors.dart';


class SocialButton extends StatelessWidget {
  final String imagePath;
  final String? buttonText; // Made optional
  final VoidCallback onTap;
  final bool isLoading;
  final double? height;
  final double? width;
  final double borderRadius;

  const SocialButton({
    Key? key,
    required this.imagePath,
    this.buttonText, // Now optional
    required this.onTap,
    this.isLoading = false,
    this.height,
    this.width,
    this.borderRadius = 25.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : () {
        HapticFeedback.heavyImpact();
        onTap();
      },
      child: Container(
        height: height ?? 52,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: AppColors.nbgcolr,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: isLoading
                ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.orange),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(imagePath),
                if (buttonText != null) ...[
                  const SizedBox(width: 20),
                  ReuseText(
                    data: buttonText!,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.txtcolr,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}


