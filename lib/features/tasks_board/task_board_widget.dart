import 'package:firebase_sample/apis/tasks_api/models/task_model.dart';
import 'package:firebase_sample/features/task_page/task_page_connector.dart';
import 'package:firebase_sample/features/tasks_board/widgets/task_container.dart';
import 'package:firebase_sample/utilities/app_starter.dart';
import 'package:firebase_sample/utilities/enums.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              onInitNewTask();
              _navigateToTaskPage(context, TaskAction.CREATE);
            },
          ),
        ],
        title: Text('Task board'),
      ),
      body: PageView(
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
                    stream: tasks.where('progress', isEqualTo: progress.index).snapshots(),
                    progress: progress,
                  ))
              .toList(),
        ],
      ),
    );
  }
}
