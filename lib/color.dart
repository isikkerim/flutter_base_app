import 'package:flutter/material.dart';

class ColorConstants {
  ColorConstants._();

  static const Color ligthTheme_color_1 = Color.fromRGBO(59, 30, 84, 1);
  static const Color ligthTheme_color_2 = Color.fromRGBO(155, 126, 189, 1);
  static const Color ligthTheme_color_3 = Color.fromRGBO(212, 190, 228, 1);
  static const Color ligthTheme_color_4 = Color.fromRGBO(238, 238, 238, 1);

  static const Color darkTheme_color_1 = Color.fromRGBO(24, 28, 20, 1);
  static const Color darkTheme_color_2 = Color.fromRGBO(60, 61, 55, 1);
  static const Color darkTheme_color_3 = Color.fromRGBO(105, 117, 101, 1);
  static const Color darkTheme_color_4 = Color.fromRGBO(236, 223, 204, 1);

  static const LinearGradient light_background_linear_gradient = LinearGradient(
    colors: [
      ligthTheme_color_1,
      ligthTheme_color_2,
      ligthTheme_color_3,
      ligthTheme_color_4
    ],
  );
  static const LinearGradient dark_background_linear_gradient = LinearGradient(
    colors: [
      darkTheme_color_1,
      darkTheme_color_2,
      darkTheme_color_3,
      darkTheme_color_4
    ],
  );
}