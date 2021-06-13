import 'package:another_flushbar/flushbar.dart';
import 'package:async_redux/async_redux.dart';
import 'package:firebase_sample/widgets/app_flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef ExceptionFlushbar = Flushbar Function(UserException error);

/// Use the [key] for specific Localizations in the app
typedef RequestFlushbar = Flushbar Function(String key, BuildContext bContext);

class UserExceptionWidget<St> extends StatelessWidget {
  const UserExceptionWidget({
    Key? key,
    required this.child,
    required this.requestFlushbar,
    this.exceptionFlushbar,
  }) : super(key: key);

  final Widget child;

  /// Manual Flushbar override
  final ExceptionFlushbar? exceptionFlushbar;

  /// Flushbar to display in releaseMode
  final RequestFlushbar requestFlushbar;

  @override
  Widget build(BuildContext context) {
    return UserExceptionDialog<St>(
      onShowUserExceptionDialog: (BuildContext context, UserException error, _) {
        if (exceptionFlushbar != null) {
          exceptionFlushbar!(error).show(context);
        } else {
          AppFlushbar.fromException(error: error).show(context);
        }
      },
      child: child,
    );
  }
}
