import 'package:flutter/material.dart';

class TextFieldController {
  final Map<String, TextEditingController> _controllers = {};

  TextEditingController getController(String key) {
    if (!_controllers.containsKey(key)) {
      _controllers[key] = TextEditingController();
    }
    return _controllers[key]!;
  }

  String getValue(String key) {
    return _controllers[key]?.text ?? '';
  }

  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());
  }
}
