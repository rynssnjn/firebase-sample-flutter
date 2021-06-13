import 'package:firebase_sample/widgets/icon_dialog.dart';
import 'package:firebase_sample/widgets/loading_button_widget.dart';
import 'package:firebase_sample/widgets/widget_spacer.dart';
import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({
    required this.onLogout,
    Key? key,
  }) : super(key: key);

  final Future<void> Function() onLogout;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return IconDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Are you sure you want to sign out?', style: textTheme.bodyText2),
          VerticalSpacer(15),
          Row(
            children: [
              Expanded(
                child: LoadingButtonWidget(
                  futureCallback: () async => Navigator.pop(context),
                  text: 'No',
                  color: Colors.blue,
                ),
              ),
              HorizontalSpacer(15),
              Expanded(
                child: LoadingButtonWidget(
                  futureCallback: () async {
                    await onLogout();
                    Navigator.pop(context);
                  },
                  text: 'Yes',
                  color: Colors.redAccent,
                ),
              )
            ],
          ),
        ],
      ),
      icon: Icons.logout,
    );
  }
}
