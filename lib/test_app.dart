import 'package:async_redux/async_redux.dart';
import 'package:firebase_sample/features/tasks_board/task_board_connector.dart';
import 'package:firebase_sample/state/app_state.dart';
import 'package:firebase_sample/utilities/app_router.dart';
import 'package:firebase_sample/utilities/app_theme.dart';
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
    return StoreProvider(
      store: store!,
      child: MaterialApp(
        theme: appTheme,
        home: Scaffold(
          body: Navigator(
            key: navigatorKey,
            // initialRoute: TestPage.route,
            initialRoute: store!.state.userState.isLoggedIn ? TaskBoardConnector.route : LoginPageConnector.route,
            onGenerateRoute: AppRouter.generateRoute,
          ),
        ),
      ),
    );
  }
}
