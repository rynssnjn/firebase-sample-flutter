import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample/features/add_task/add_task_connector.dart';
import 'package:firebase_sample/features/tasks_board/widgets/task_card.dart';
import 'package:firebase_sample/utilities/app_starter.dart';
import 'package:firebase_sample/utilities/extensions.dart';
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
              Navigator.pushNamed(context, AddTaskConnector.route);
            },
          ),
        ],
        title: Text('Task board'),
      ),
      body: StreamBuilder(
        stream: taskStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(strokeWidth: 2.0),
              ),
            );
          }

          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs.map((e) {
              return TaskCard(
                id: e.id,
                title: e.toTask.title,
                progress: e.toTask.progress,
                type: e.toTask.type,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
