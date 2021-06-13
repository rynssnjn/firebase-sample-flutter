import 'package:firebase_sample/apis/tasks_api/models/task_model.dart';
import 'package:firebase_sample/features/task_page/widgets/read_only_fields.dart';
import 'package:firebase_sample/utilities/enums.dart';
import 'package:firebase_sample/utilities/extensions.dart';
import 'package:firebase_sample/widgets/loading_widget.dart';
import 'package:firebase_sample/widgets/widget_spacer.dart';
import 'package:flutter/material.dart';

class ActionDialog extends StatelessWidget {
  const ActionDialog({
    required this.onEditTask,
    required this.onMoveTask,
    required this.onDeleteTask,
    this.task,
    Key? key,
  }) : super(key: key);

  final VoidCallback onEditTask;
  final Future<void> Function(TaskProgress progress) onMoveTask;
  final Future<void> Function() onDeleteTask;
  final TaskModel? task;

  void _onEditTask(BuildContext context) {
    onEditTask();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      elevation: 10,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 10),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(task!.title!, style: textTheme.headline4),
                  subtitle: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 8,
                        color: task!.priority!.color,
                      ),
                      HorizontalSpacer(10),
                      Text(
                        '${task!.priority!.stringValue} Priority',
                        style: textTheme.subtitle1,
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () => _onEditTask(context),
                    icon: Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(
                  task!.description!,
                  style: textTheme.bodyText2,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                if (task!.description!.length > 100) ...[
                  VerticalSpacer(5),
                  InkWell(
                    onTap: () => _onEditTask(context),
                    child: Text(
                      'See full description',
                      style: textTheme.bodyText2!.copyWith(
                        decoration: TextDecoration.underline,
                        color: Colors.green,
                      ),
                      maxLines: 10,
                    ),
                  ),
                ],
                ReadOnlyFields(
                  creationDate: task!.creationDate,
                  reporter: task!.creator,
                ),
                VerticalSpacer(25),
                Text('Move to:', style: textTheme.headline4),
                ...TaskProgress.values
                    .where((p) => p != task!.progress)
                    .map((e) => LoadingWidget(
                          futureCallback: () async {
                            await onMoveTask(e);
                            Navigator.pop(context);
                          },
                          renderChild: (isLoading, onTap) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(MediaQuery.of(context).size.width, 40),
                              primary: Colors.green,
                            ),
                            onPressed: onTap,
                            child: isLoading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : Text(e.stringValue.toUpperCase()),
                          ),
                        ))
                    .toList(),
                VerticalSpacer(10),
                LoadingWidget(
                  futureCallback: () async {
                    await onDeleteTask();
                    Navigator.pop(context);
                  },
                  renderChild: (isLoading, onTap) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      primary: Colors.red,
                    ),
                    onPressed: onTap,
                    child: isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text('Delete'),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: CircleAvatar(
              backgroundColor: task!.type!.color,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  task!.type!.icon,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
