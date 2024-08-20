import 'package:flight_management_system/core/utils/color_constants.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  TextFieldWidget({
    super.key,
    required this.controller,
    required this.isPassword,
    required this.labelText,
  });

  final TextEditingController controller;
  bool isPassword;
  final String labelText;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: widget.labelText == 'Password'
            ? IconButton(
                icon: Icon(

                  widget.isPassword ? Icons.visibility : Icons.visibility_off,
                  color: ColorConstants.appBarColor,
                ),
                onPressed: () {
                  setState(() {
                    widget.isPassword = !widget.isPassword;
                  });
                  widget.isPassword ? 'Password' : 'Email';
                  const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorConstants.darkOrangeColor),
                  );
                },
              )
            : null,
      ),
    );
  }
}
