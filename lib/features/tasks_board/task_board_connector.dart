import 'package:async_redux/async_redux.dart';
import 'package:firebase_sample/apis/tasks_api/models/task_model.dart';
import 'package:firebase_sample/features/tasks_board/task_board_widget.dart';
import 'package:firebase_sample/state/actions/task_actions.dart';
import 'package:firebase_sample/state/app_state.dart';
import 'package:flutter/material.dart';

class TaskBoardViewModel extends BaseModel<AppState> {
  TaskBoardViewModel();

  TaskBoardViewModel.build({
    this.onInitNewTask,
    this.onSelectTask,
    this.onMoveTask,
    this.onDeleteTask,
  }) : super(equals: []);

  Function()? onInitNewTask;
  Function(TaskModel model)? onSelectTask;
  Future<void> Function(String id, TaskModel task)? onMoveTask;
  Future<void> Function(String id)? onDeleteTask;

  @override
  BaseModel fromStore() {
    return TaskBoardViewModel.build(
      onInitNewTask: () => dispatch!(InitTask()),
      onSelectTask: (task) => dispatch!(InitTask(task: task)),
      onMoveTask: _onMoveTask,
      onDeleteTask: _onDeleteTask,
    );
  }

  Future<void> _onMoveTask(String id, TaskModel task) async => await dispatchFuture!(UpdateTask(id, task));

  Future<void> _onDeleteTask(String id) async => await dispatchFuture!(DeleteTask(id));
}

class TaskBoardConnector extends StatelessWidget {
  static const route = 'task-board';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskBoardViewModel>(
      model: TaskBoardViewModel(),
      builder: (context, vm) => TaskBoardWidget(
        onInitNewTask: vm.onInitNewTask!,
        onSelectTask: vm.onSelectTask!,
        onMoveTask: vm.onMoveTask!,
        onDeleteTask: vm.onDeleteTask!,
      ),
    );
  }
}
