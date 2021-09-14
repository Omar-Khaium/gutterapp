import 'package:flutter/material.dart';
import 'package:gutterapp/utils/text_styles.dart';

class AppSnackBar {
  static SnackBar getErrorSnackBar(BuildContext context, String message) {
    return SnackBar(
      content: Text(message, style: TextStyles.body(context: context, color: Colors.white)),
      backgroundColor: Colors.redAccent.shade400,
      duration: Duration(milliseconds: 1500),
    );
  }
}
