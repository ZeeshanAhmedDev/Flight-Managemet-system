import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BuildAlert extends StatelessWidget {
  final String theTitle;
  final String desc;
  final BuildContext myContext;

  const BuildAlert({
    super.key,
    required this.theTitle,
    required this.desc,
    required this.myContext,
  });

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => _showAlert());
    return Container();
  }

  void _showAlert() {
    Alert(
      context: myContext,
      title: theTitle,
      desc: desc,
    ).show();
  }
}
