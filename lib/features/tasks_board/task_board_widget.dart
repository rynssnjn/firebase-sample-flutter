import 'package:firebase_sample/features/task_page/task_page_connector.dart';
import 'package:firebase_sample/features/tasks_board/widgets/task_container.dart';
import 'package:firebase_sample/utilities/app_starter.dart';
import 'package:firebase_sample/utilities/enums.dart';
import 'package:flutter/material.dart';

class TaskBoardWidget extends StatelessWidget {
  const TaskBoardWidget({
    required this.onInitNewTask,
    Key? key,
  }) : super(key: key);

  final VoidCallback onInitNewTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              onInitNewTask();
              Navigator.pushNamed(context, TaskPageConnector.route);
            },
          ),
        ],
        title: Text('Task board'),
      ),
      body: PageView(
        children: [
          TaskContainer(
            stream: tasks.where('progress', isEqualTo: 0).snapshots(),
            progress: TaskProgress.TODO,
          ),
          TaskContainer(
            stream: tasks.where('progress', isEqualTo: 1).snapshots(),
            progress: TaskProgress.IN_PROGRESS,
          ),
          TaskContainer(
            stream: tasks.where('progress', isEqualTo: 2).snapshots(),
            progress: TaskProgress.IN_TESTING,
          ),
          TaskContainer(
            stream: tasks.where('progress', isEqualTo: 3).snapshots(),
            progress: TaskProgress.DONE,
          ),
        ],
      ),
    );
  }
}
