import 'package:async_redux/async_redux.dart';
import 'package:firebase_sample/apis/tasks_api/models/task_model.dart';
import 'package:firebase_sample/features/task_page/task_page_widget.dart';
import 'package:firebase_sample/models/union_task_form.dart';
import 'package:firebase_sample/state/actions/task_actions.dart';
import 'package:firebase_sample/state/app_state.dart';
import 'package:flutter/material.dart';

class TaskPageViewModel extends BaseModel<AppState> {
  TaskPageViewModel();

  TaskPageViewModel.build({
    this.onAddTask,
    this.onUpdateTask,
    this.newTask,
  }) : super(equals: []);

  Future<void> Function()? onAddTask;
  Function(UnionTaskForm form)? onUpdateTask;
  TaskModel? newTask;

  @override
  BaseModel fromStore() {
    return TaskPageViewModel.build(
      onAddTask: _onAddTask,
      onUpdateTask: _onUpdateTask,
      newTask: _task,
    );
  }

  Future<void> _onAddTask() async => await dispatchFuture!(AddTask());

  TaskModel get _task => state.taskState.newTask!;

  void _onUpdateTask(UnionTaskForm form) {
    final updatedTask = form.when(
      title: (value) => _task.copyWith(title: value),
      description: (value) => _task.copyWith(description: value),
      type: (value) => _task.copyWith(type: value),
      priority: (value) => _task.copyWith(priority: value),
    );

    dispatch!(EditTask(task: updatedTask));
  }
}

class TaskPageConnector extends StatelessWidget {
  static const route = 'task-page';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskPageViewModel>(
      model: TaskPageViewModel(),
      builder: (context, vm) => TaskPageWidget(
        onSaveTask: vm.onAddTask!,
        onChangeTitle: (text) => vm.onUpdateTask!(UnionTaskForm.title(text)),
        onChangeDescription: (text) => vm.onUpdateTask!(UnionTaskForm.description(text)),
        onChangeTicketType: (type) => vm.onUpdateTask!(UnionTaskForm.type(type)),
        onChangePriority: (priority) => vm.onUpdateTask!(UnionTaskForm.priority(priority)),
        type: vm.newTask!.type,
        priority: vm.newTask!.priority,
      ),
    );
  }
}
