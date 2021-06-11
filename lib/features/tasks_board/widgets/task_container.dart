import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample/features/tasks_board/widgets/task_card.dart';
import 'package:firebase_sample/utilities/colors.dart';
import 'package:firebase_sample/utilities/enums.dart';
import 'package:firebase_sample/utilities/extensions.dart';
import 'package:firebase_sample/widgets/widget_spacer.dart';
import 'package:flutter/material.dart';

class TaskContainer extends StatelessWidget {
  const TaskContainer({
    required this.stream,
    this.progress,
    Key? key,
  }) : super(key: key);

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
                    onTap: () => print('asd'),
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
