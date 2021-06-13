import 'package:another_flushbar/flushbar.dart';
import 'package:async_redux/async_redux.dart';
import 'package:firebase_sample/features/tasks_board/task_board_connector.dart';
import 'package:firebase_sample/state/app_state.dart';
import 'package:firebase_sample/utilities/app_router.dart';
import 'package:firebase_sample/utilities/app_theme.dart';
import 'package:firebase_sample/widgets/user_exception_widget.dart';
import 'package:flutter/material.dart';

import 'features/login_page/login_page_connector.dart';

class TestApp extends StatelessWidget {
  const TestApp({
    this.store,
    Key? key,
  }) : super(key: key);

  final Store<AppState>? store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store!,
      child: MaterialApp(
        theme: appTheme,
        home: UserExceptionWidget<AppState>(
          requestFlushbar: (key, c) => Flushbar(
            title: key,
            message: key,
          ),
          child: WillPopScope(
            onWillPop: () async => !await navigatorKey.currentState!.maybePop(),
            child: Navigator(
              key: navigatorKey,
              initialRoute: store!.state.userState.isLoggedIn ? TaskBoardConnector.route : LoginPageConnector.route,
              onGenerateRoute: AppRouter.generateRoute,
            ),
          ),
        ),
      ),
    );
  }
}
