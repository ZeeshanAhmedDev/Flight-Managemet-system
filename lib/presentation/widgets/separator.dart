import 'package:flutter/cupertino.dart';

class Separator extends StatelessWidget {
  const Separator({
    super.key,
    required this.height,
  });
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
