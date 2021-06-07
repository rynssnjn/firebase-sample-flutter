import 'package:async_redux/async_redux.dart';
import 'package:firebase_sample/apis/tasks_api/models/task_model.dart';
import 'package:firebase_sample/features/add_task/add_task_widget.dart';
import 'package:firebase_sample/models/union_task_form.dart';
import 'package:firebase_sample/state/actions/task_actions.dart';
import 'package:firebase_sample/state/app_state.dart';
import 'package:flutter/material.dart';

class AddTaskViewModel extends BaseModel<AppState> {
  AddTaskViewModel();

  AddTaskViewModel.build({
    this.onAddTask,
    this.onUpdateTask,
  }) : super(equals: []);

  Future<void> Function(TaskModel data)? onAddTask;
  Function(UnionTaskForm form)? onUpdateTask;

  @override
  BaseModel fromStore() {
    return AddTaskViewModel.build(
      onAddTask: _onAddTask,
      onUpdateTask: _onUpdateTask,
    );
  }

  Future<void> _onAddTask(TaskModel data) async => await dispatchFuture!(AddTask(data));

  TaskModel get _task => state.taskState.newTask!;

  void _onUpdateTask(UnionTaskForm form) {
    final updatedTask = form.when(
      title: (value) => _task.copyWith(title: value!),
      description: (value) => _task.copyWith(description: value!),
    );

    dispatch!(EditTask(task: updatedTask));
  }
}

class AddTaskConnector extends StatelessWidget {
  static const route = 'add-task';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AddTaskViewModel>(
      model: AddTaskViewModel(),
      builder: (context, vm) => AddTaskWidget(
        onAddTask: vm.onAddTask!,
        onUpdateTask: vm.onUpdateTask!,
      ),
    );
  }
}
