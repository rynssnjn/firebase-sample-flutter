import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/apis/api_service.dart';
import 'package:firebase_sample/apis/tasks_api/models/task_model.dart';
import 'package:firebase_sample/features/task_page/task_page_connector.dart';
import 'package:firebase_sample/features/tasks_board/widgets/task_container.dart';
import 'package:firebase_sample/utilities/enums.dart';
import 'package:firebase_sample/utilities/extensions.dart';
import 'package:flutter/material.dart';

class TaskBoardWidget extends StatelessWidget {
  const TaskBoardWidget({
    required this.onInitNewTask,
    required this.onSelectTask,
    required this.onMoveTask,
    required this.onDeleteTask,
    Key? key,
  }) : super(key: key);

  final VoidCallback onInitNewTask;
  final Function(TaskModel task) onSelectTask;
  final Future<void> Function(String id, TaskModel task) onMoveTask;
  final Future<void> Function(String id) onDeleteTask;

  void _navigateToTaskPage(BuildContext context, TaskAction action) => Navigator.pushNamed(
        context,
        TaskPageConnector.route,
        arguments: TaskPageArguments(action: action),
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                onInitNewTask();
                _navigateToTaskPage(context, TaskAction.CREATE);
              },
            ),
          ],
          title: Text('Task board'),
          bottom: TabBar(
            tabs: TaskProgress.values
                .map((e) => Tab(
                      icon: Icon(e.icon),
                      child: FittedBox(child: Text(e.stringValue)),
                    ))
                .toList(),
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            ...TaskProgress.values
                .map((progress) => TaskContainer(
                      onSelectTask: onSelectTask,
                      onMoveTask: onMoveTask,
                      onDeleteTask: onDeleteTask,
                      onEditTapped: (id) {
                        Navigator.pushNamed(
                          context,
                          TaskPageConnector.route,
                          arguments: TaskPageArguments(action: TaskAction.EDIT, taskId: id),
                        );
                      },
                      stream: ApiService().taskApi.collection.where('progress', isEqualTo: progress.index).snapshots(),
                      progress: progress,
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
