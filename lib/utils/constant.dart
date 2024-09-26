import 'package:flutter/material.dart';

class AppColor {
  static const appMainColor = Color(0xFFFFFFFF);
  static const appbarColor = Color(0xFF7e91dc);
  static const tilebgColor = Color(0xFFcbd2f2);
  static const headingColor = Color(0xFF242348);
  static const textColor = Color(0xFF333475);
  static const background = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Color(0xFFcbd2f2),
        Color(0xFFa8b6e8),
      ]);
}

TextStyle heading(double size,Color color) {
  return TextStyle(
    fontFamily: 'akronim',
    fontSize: size,
    color: color
  );
}
TextStyle text(double size,Color color,{FontWeight weight = FontWeight.w600}) {
  return TextStyle(
    fontFamily: 'akaya',
    fontSize: size,
    color: color,
    fontWeight: weight
  );
}
// 'cerulean-blue': {
//         '50': '#f2f4fc',
//         '100': '#e2e6f7',
//         '200': '#cbd2f2',
//         '300': '#a8b6e8',
//         '400': '#7e91dc',
//         '500': '#5f6fd2',
//         '600': '#4a52c4',
//         '700': '#4143b4',
//         '800': '#3b3a93',
//         '900': '#333475',
//         '950': '#242348',
//     },
    