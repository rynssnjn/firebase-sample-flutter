import 'package:firebase_sample/apis/tasks_api/models/task_model.dart';
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
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(task!.title!, style: textTheme.headline4),
            trailing: IconButton(
              onPressed: () {
                _onEditTask(context);
              },
              icon: Icon(
                Icons.edit,
                color: Colors.green,
              ),
            ),
          ),
          VerticalSpacer(10),
          Text(
            task!.description!,
            style: textTheme.bodyText1,
            maxLines: 10,
          ),
          if (task!.description!.length > 500)
            InkWell(
              onTap: () => _onEditTask(context),
              child: Text(
                'See full description',
                style: textTheme.bodyText1!.copyWith(
                  decoration: TextDecoration.underline,
                  color: Colors.green,
                ),
                maxLines: 10,
              ),
            ),
          VerticalSpacer(25),
          ...TaskProgress.values
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
                          : Text('Move in ${e.stringValue}'),
                    ),
                  ))
              .toList(),
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
    );
  }
}
