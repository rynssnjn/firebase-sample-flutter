import 'package:firebase_sample/apis/tasks_api/models/task_model.dart';
import 'package:firebase_sample/models/union_task_form.dart';
import 'package:firebase_sample/utilities/enums.dart';
import 'package:firebase_sample/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class AddTaskWidget extends StatelessWidget {
  const AddTaskWidget({
    required this.onAddTask,
    // required this.onChangeTitle,
    // required this.onChangeDescription,
    required this.onUpdateTask,
    Key? key,
  }) : super(key: key);

  final Future<void> Function(TaskModel task) onAddTask;
  // final Function(String text) onChangeTitle;
  // final Function(String text) onChangeDescription;
  final Function(UnionTaskForm form) onUpdateTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Add Task')),
      body: Column(
        children: [
          TextField(
            onChanged: (text) => onUpdateTask(UnionTaskForm.title(text)),
          ),
          TextField(
            onChanged: (text) => onUpdateTask(UnionTaskForm.description(text)),
          ),
          Center(
            child: LoadingWidget(
              futureCallback: () async {
                final model = TaskModel(
                  title: 'TASK1',
                  description: 'asdasdas asda s',
                  type: TicketType.BUG,
                  progress: TaskProgress.TODO,
                );
                await onAddTask(model);
                Navigator.pop(context);
              },
              renderChild: (isLoading, onTap) => isLoading
                  ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: onTap,
                      child: Text('Save to Database'),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
