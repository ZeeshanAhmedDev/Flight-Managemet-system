import 'package:flutter/material.dart';

Widget buildFooterSection() {
  return Column(children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildFooterLink("About"),
            buildFooterLink("Privacy"),
            buildFooterLink("Terms"),
            buildFooterLink("Feedback"),
            buildFooterLink("Help Center"),
          ],
        ),
      ],
    )
  ]);
}

Widget buildFooterLink(String text) {
  return TextButton(
    onPressed: () {},
    child: Text(
      text,
      style: const TextStyle(color: Colors.black),
    ),
  );
}
