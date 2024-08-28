import 'package:flutter/material.dart';
import '../../core/utils/color_constants.dart';
import '../../core/utils/screen_size.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.screenSizeMediaQuery,
    required this.onTap,
    required this.text,
    required this.isHollowButton,
  });

  final ScreenSizeMediaQuery screenSizeMediaQuery;
  final VoidCallback onTap;
  final String text;
  final bool isHollowButton;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        side: isHollowButton
            ? const BorderSide(color: ColorConstants.blueColor)
            : BorderSide.none,
        foregroundColor: isHollowButton ? Colors.blue : Colors.white,
        fixedSize: Size(
          screenSizeMediaQuery.width * 0.3,
          screenSizeMediaQuery.height * 0.05,
        ),
        backgroundColor:
            isHollowButton ? Colors.white : ColorConstants.appBarColor,
        textStyle: TextStyle(
          fontSize: screenSizeMediaQuery.height * 0.025,
          fontWeight: FontWeight.w100,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isHollowButton ? Colors.blue : Colors.white,
          fontWeight: FontWeight.w100,
        ),
      ),
    );
  }
}
