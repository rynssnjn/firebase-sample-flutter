import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample/apis/tasks_api/models/task_model.dart';
import 'package:firebase_sample/features/tasks_board/widgets/action_dialog.dart';
import 'package:firebase_sample/features/tasks_board/widgets/task_card.dart';
import 'package:firebase_sample/utilities/colors.dart';
import 'package:firebase_sample/utilities/enums.dart';
import 'package:firebase_sample/utilities/extensions.dart';
import 'package:firebase_sample/widgets/widget_spacer.dart';
import 'package:flutter/material.dart';

class TaskContainer extends StatelessWidget {
  const TaskContainer({
    required this.onSelectTask,
    required this.onEditTapped,
    required this.onMoveTask,
    required this.onDeleteTask,
    required this.stream,
    this.progress,
    Key? key,
  }) : super(key: key);

  final Function(TaskModel task) onSelectTask;
  final Function(String id) onEditTapped;
  final Future<void> Function(String id, TaskModel task) onMoveTask;
  final Future<void> Function(String id) onDeleteTask;
  final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  final TaskProgress? progress;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: lightGrey,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(progress!.stringValue, style: textTheme.headline6),
          VerticalSpacer(10),
          StreamBuilder(
            stream: stream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Expanded(child: Text('error'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(strokeWidth: 2.0),
                    ),
                  ),
                );
              }
              return ListView(
                shrinkWrap: true,
                children: snapshot.data!.docs.map((e) {
                  return TaskCard(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => ActionDialog(
                          onEditTask: () {
                            onSelectTask(e.toTask);
                            onEditTapped(e.id);
                          },
                          onMoveTask: (p) async => await onMoveTask(e.id, e.toTask.copyWith(progress: p)),
                          onDeleteTask: () => onDeleteTask(e.id),
                          task: e.toTask,
                        ),
                      );
                    },
                    id: e.id,
                    title: e.toTask.title,
                    type: e.toTask.type,
                    priority: e.toTask.priority,
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
