import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/// * AppErrorView is a widget that displays error information.
class AppErrorView extends StatelessWidget {
  final Level level;
  final String message;
  final double? fontSize;
  final double? textScaleFactor;

  const AppErrorView({
    Key? key,
    this.level = Level.error,
    this.message = "",
    this.fontSize,
    this.textScaleFactor = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Text(
          message,
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.red,
          ),
          textScaleFactor: textScaleFactor,
        ),
      ),
    );
  }
}
