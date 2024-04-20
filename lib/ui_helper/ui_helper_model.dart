import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UiHelper {
  static CustomTextField(
    controller,
    bool hide,
    String hintText,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            enabled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            )),
        obscureText: hide,
      ),
    );
  }

  static CustomTextFieldWithIcon(controller, bool hide, String hintText,
      IconData iconData, TextInputType textInput) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        keyboardType: textInput,
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: Icon(iconData),
            hintText: hintText,
            enabled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            )),
        obscureText: hide,
      ),
    );
  }

  static CustomTextFieldWithIconInRow(
    controller,
    bool hide,
    String hintText,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 10),
      child: Container(
        height: 75,
        width: 145,
        child: Center(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                hintText: hintText,
                enabled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
            obscureText: hide,
          ),
        ),
      ),
    );
  }

  static CustomUserNote(
    controller,
    bool hide,
    String hintText,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        enabled: true,
        maxLines: 20,
        controller: controller,
        decoration: InputDecoration.collapsed(
          hintText: hintText,
          enabled: true,
          border: InputBorder.none,
        ),
        obscureText: hide,
      ),
    );
  }

  static CustomAlertBox(String message, String title, VoidCallback onPressed) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed,
          child: Text('OK'),
        ),
      ],
    );
  }
}
