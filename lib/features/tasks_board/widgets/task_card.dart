import 'package:firebase_sample/utilities/enums.dart';
import 'package:firebase_sample/utilities/extensions.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    this.id,
    this.title,
    this.progress,
    this.type,
    Key? key,
  }) : super(key: key);

  final String? id;
  final String? title;
  final TaskProgress? progress;
  final TicketType? type;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: Container(
          height: 20,
          width: 20,
          color: type!.color,
        ),
        title: Text(title!),
        subtitle: Text(id!),
        trailing: Text(progress!.stringValue),
      ),
    );
  }
}
