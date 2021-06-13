import 'package:another_flushbar/flushbar.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppFlushbar extends Flushbar<dynamic> {
  AppFlushbar({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
    Icon? icon,
    Widget? mainButton,
  }) : super(
          title: title,
          message: message,
          icon: icon,
          animationDuration: const Duration(milliseconds: 400),
          duration: duration,
          margin: const EdgeInsets.all(8.0),
          borderRadius: BorderRadius.circular(8.0),
          mainButton: mainButton,
          shouldIconPulse: false,
        );

  AppFlushbar.fromException({
    required UserException error,
  }) : this(
          title: error.dialogTitle() != null && error.dialogTitle()!.isNotEmpty
              ? error.dialogTitle()!
              : 'Authentication Error',
          message: error.dialogContent() != null && error.dialogContent()!.isNotEmpty ? error.dialogContent()! : ' ',
          icon: const Icon(Icons.warning, color: Colors.grey),
        );
}
