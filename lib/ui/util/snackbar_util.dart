import 'package:flutter/material.dart';

extension SnackBarUtil on BuildContext {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String message, {
    SnackBarAction? action,
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      action: action,
    ));
  }
}
