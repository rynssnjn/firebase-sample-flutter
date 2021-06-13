import 'package:async_redux/async_redux.dart';
import 'package:firebase_sample/apis/tasks_api/models/task_model.dart';
import 'package:firebase_sample/features/login_page/login_page_connector.dart';
import 'package:firebase_sample/features/tasks_board/task_board_widget.dart';
import 'package:firebase_sample/state/actions/task_actions.dart';
import 'package:firebase_sample/state/actions/user_actions.dart';
import 'package:firebase_sample/state/app_state.dart';
import 'package:flutter/material.dart';

class TaskBoardViewModel extends BaseModel<AppState> {
  TaskBoardViewModel();

  TaskBoardViewModel.build({
    this.onInitNewTask,
    this.onSelectTask,
    this.onMoveTask,
    this.onDeleteTask,
    this.onLogout,
    this.isLoggedInEvt,
  }) : super(equals: [isLoggedInEvt]);

  Function()? onInitNewTask;
  Function(TaskModel model)? onSelectTask;
  Future<void> Function(String id, TaskModel task)? onMoveTask;
  Future<void> Function(String id)? onDeleteTask;
  Future<void> Function()? onLogout;
  Event<bool>? isLoggedInEvt;

  @override
  BaseModel fromStore() {
    return TaskBoardViewModel.build(
      onInitNewTask: () => dispatch!(InitTask()),
      onSelectTask: (task) => dispatch!(InitTask(task: task)),
      onMoveTask: _onMoveTask,
      onDeleteTask: _onDeleteTask,
      onLogout: _onLogout,
      isLoggedInEvt: state.userState.isLoggedInEvt,
    );
  }

  Future<void> _onMoveTask(String id, TaskModel task) async => await dispatchFuture!(UpdateTask(id, task));

  Future<void> _onDeleteTask(String id) async => await dispatchFuture!(DeleteTask(id));

  Future<void> _onLogout() async => await dispatchFuture!(LogoutUser());
}

class TaskBoardConnector extends StatelessWidget {
  static const route = 'task-board';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskBoardViewModel>(
      model: TaskBoardViewModel(),
      onDidChange: (c, store, vm) {
        if (vm.isLoggedInEvt?.consume() == false) {
          Navigator.pushReplacementNamed(context, LoginPageConnector.route);
        }
      },
      builder: (context, vm) => TaskBoardWidget(
        onInitNewTask: vm.onInitNewTask!,
        onSelectTask: vm.onSelectTask!,
        onMoveTask: vm.onMoveTask!,
        onDeleteTask: vm.onDeleteTask!,
        onLogout: vm.onLogout!,
      ),
    );
  }
}
