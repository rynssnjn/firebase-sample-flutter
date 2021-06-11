import 'package:firebase_sample/features/task_page/task_page_connector.dart';
import 'package:firebase_sample/features/tasks_board/task_board_connector.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case TaskBoardConnector.route:
        return MaterialPageRoute<dynamic>(builder: (_) => TaskBoardConnector());
      case TaskPageConnector.route:
        return MaterialPageRoute<dynamic>(builder: (_) => TaskPageConnector());
      default:
        return MaterialPageRoute<dynamic>(builder: (_) => Scaffold(body: Center(child: Text('empty'))));
    }
  }
}
