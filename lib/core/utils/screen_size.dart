import 'package:flutter/material.dart';

class ScreenSizeMediaQuery {
  final BuildContext context;

  ScreenSizeMediaQuery({required this.context});

  double get height => MediaQuery.of(context).size.height;
  double get width => MediaQuery.of(context).size.width;
}
