import 'package:flutter/material.dart';

class AppColors {
  static const Color orange = Color(0xffF25943);
  static const Color nbgcolr = Color(0xff323539);
  static const Color bgcolr = Color(0xff1F222A);
  static const Color txtcolr = Color(0xffFFFFFF);
  static const Color txtgrey = Color(0xffCBCBCB);
}
class AppStyles {
  AppStyles._();
  static TextStyle grey12 = const TextStyle(
    color: AppColors.txtcolr,
    fontWeight: FontWeight.w300,
    fontSize: 12.0,
    fontFamily: 'Poppins',
  );

}