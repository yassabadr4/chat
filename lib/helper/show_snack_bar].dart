
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: message == "Success" ? Colors.green : Colors.red,
    content: Text(message),

  ));
}
