import 'package:flutter/material.dart';

/// * AppListEmpty is a widget that displays empty list information.
class AppListEmpty extends StatelessWidget {
  final String message;
  final int code;

  const AppListEmpty({
    super.key,
    this.message = "Nothing found!!",
    this.code = 406,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(message),
      leading: const Icon(Icons.notification_important_outlined),
    ));
  }
}

/// * AppItemEmpty is a widget that displays empty item information.
class AppItemEmpty extends StatelessWidget {
  final String message;
  final int code;

  const AppItemEmpty({
    super.key,
    this.message = "Nothing found!!",
    this.code = 406,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(message),
        leading: const Icon(Icons.notification_important_outlined),
      ),
    );
  }
}
