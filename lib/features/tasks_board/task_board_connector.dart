import 'package:async_redux/async_redux.dart';
import 'package:firebase_sample/features/tasks_board/task_board_widget.dart';
import 'package:firebase_sample/state/actions/task_actions.dart';
import 'package:firebase_sample/state/app_state.dart';
import 'package:flutter/material.dart';

class TaskBoardViewModel extends BaseModel {
  TaskBoardViewModel();

  TaskBoardViewModel.build({
    this.onInitNewTask,
  }) : super(equals: []);

  Function()? onInitNewTask;

  @override
  BaseModel fromStore() {
    return TaskBoardViewModel.build(
      onInitNewTask: () => dispatch!(InitNewTask()),
    );
  }

}

class TaskBoardConnector extends StatelessWidget {
  static const route = 'task-board';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskBoardViewModel>(
      model: TaskBoardViewModel(),
      builder: (context, vm) => TaskBoardWidget(
        onInitNewTask: vm.onInitNewTask!,
      ),
    );
  }
}
