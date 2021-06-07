import 'package:firebase_sample/features/add_task/add_task_connector.dart';
import 'package:firebase_sample/features/home/home_page_connector.dart';
import 'package:firebase_sample/features/tasks_board/task_board_connector.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePageConnector.route:
        return MaterialPageRoute<dynamic>(builder: (_) => HomePageConnector());
      case TaskBoardConnector.route:
        return MaterialPageRoute<dynamic>(builder: (_) => TaskBoardConnector());
      case AddTaskConnector.route:
        return MaterialPageRoute<dynamic>(builder: (_) => AddTaskConnector());
      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('empty'),
            ),
          ),
        );
    }
  }
}
