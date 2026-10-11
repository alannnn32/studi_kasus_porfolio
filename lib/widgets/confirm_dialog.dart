import 'package:flutter/material.dart';

import '../l10n/app_strings.dart';

Future<bool> confirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String? confirmText,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: Text(ctx.tr('cancel')),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(confirmText ?? ctx.tr('delete')),
        ),
      ],
    ),
  );
  return result ?? false;
}