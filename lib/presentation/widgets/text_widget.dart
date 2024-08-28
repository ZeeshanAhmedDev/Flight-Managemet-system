import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/screen_size.dart';

class DataShowerTextWidget extends StatelessWidget {
  const DataShowerTextWidget({
    super.key,
    required this.screenSizeMediaQuery,
    required this.textColor,
    required this.fontWeight,
    required this.fontSize,
    required this.text,
  });

  final ScreenSizeMediaQuery screenSizeMediaQuery;
  final String text;
  final Color textColor;
  final FontWeight fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        textStyle: Theme.of(context).textTheme.displayLarge,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
      ),
    );
  }
}
