import 'package:async_redux/async_redux.dart';
import 'package:firebase_sample/apis/tasks_api/models/task_model.dart';
import 'package:firebase_sample/features/task_page/task_page_widget.dart';
import 'package:firebase_sample/models/union_task_form.dart';
import 'package:firebase_sample/state/actions/task_actions.dart';
import 'package:firebase_sample/state/app_state.dart';
import 'package:firebase_sample/utilities/enums.dart';
import 'package:flutter/material.dart';

class TaskPageViewModel extends BaseModel<AppState> {
  TaskPageViewModel();

  TaskPageViewModel.build({
    this.onAddTask,
    this.onUpdateTask,
    this.onDeleteTask,
    this.onEditTask,
    this.newTask,
  }) : super(equals: []);

  Future<void> Function()? onAddTask;
  Future<void> Function(String id)? onUpdateTask;
  Future<void> Function(String id)? onDeleteTask;
  Function(UnionTaskForm form)? onEditTask;
  TaskModel? newTask;

  @override
  BaseModel fromStore() {
    return TaskPageViewModel.build(
      onAddTask: _onAddTask,
      onUpdateTask: _onUpdateTask,
      onDeleteTask: _onDeleteTask,
      onEditTask: _onEditTask,
      newTask: _task,
    );
  }

  Future<void> _onAddTask() async => await dispatchFuture!(AddTask());

  Future<void> _onUpdateTask(String id) async => await dispatchFuture!(UpdateTask(id, state.taskState.task!));

  Future<void> _onDeleteTask(String id) async => await dispatchFuture!(DeleteTask(id));

  TaskModel get _task => state.taskState.task!;

  void _onEditTask(UnionTaskForm form) {
    final updatedTask = form.when(
      title: (value) => _task.copyWith(title: value),
      description: (value) => _task.copyWith(description: value),
      type: (value) => _task.copyWith(type: value),
      priority: (value) => _task.copyWith(priority: value),
      progress: (value) => _task.copyWith(progress: value),
    );

    dispatch!(EditTask(task: updatedTask));
  }
}

class TaskPageArguments {
  const TaskPageArguments({
    this.action,
    this.taskId,
  });

  final TaskAction? action;
  final String? taskId;
}

class TaskPageConnector extends StatelessWidget {
  static const route = 'task-page';

  const TaskPageConnector({required this.args});

  final TaskPageArguments args;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskPageViewModel>(
      model: TaskPageViewModel(),
      builder: (context, vm) => TaskPageWidget(
        onSaveTask: vm.onAddTask!,
        onUpdateTask: () => vm.onUpdateTask!(args.taskId!),
        onDeleteTask: () => vm.onDeleteTask!(args.taskId!),
        onEditTask: vm.onEditTask,
        task: vm.newTask,
        action: args.action,
      ),
    );
  }
}
