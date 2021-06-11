import 'package:firebase_sample/utilities/enums.dart';
import 'package:firebase_sample/utilities/extensions.dart';
import 'package:firebase_sample/widgets/widget_spacer.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.onTap,
    this.id,
    this.title,
    this.type,
    this.priority,
    Key? key,
  }) : super(key: key);

  final VoidCallback onTap;
  final String? id;
  final String? title;
  final TicketType? type;
  final PriorityLevel? priority;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 32,
          ),
          child: Row(
            children: [
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: type!.color,
                ),
                child: Icon(
                  type!.icon,
                  size: 15,
                  color: Colors.white,
                ),
              ),
              HorizontalSpacer(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title!, style: textTheme.headline4),
                  Text(id!, style: textTheme.bodyText1),
                ],
              ),
              Spacer(),
              Transform.rotate(
                angle: 80.1,
                child: Icon(
                  Icons.double_arrow,
                  size: 20,
                  color: priority!.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
