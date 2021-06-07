import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:firebase_sample/apis/tasks_api/handlers/task_model_handler.dart';
import 'package:firebase_sample/apis/tasks_api/models/task_model.dart';
import 'package:firebase_sample/state/app_state.dart';
import 'package:firebase_sample/utilities/enums.dart';

class InitNewTask extends ReduxAction<AppState> {
  @override
  AppState? reduce() {
    final model = TaskModel(
      title: '',
      description: '',
      type: TicketType.BUG,
      progress: TaskProgress.TODO,
    );
    return state.copyWith.taskState(newTask: model);
  }
}

class AddTask extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    await TaskApi().create(state.taskState.newTask!);

    return null;
  }
}

class UpdateTask extends ReduxAction<AppState> {
  UpdateTask(this.id, this.task);

  final String id;
  final TaskModel task;

  @override
  Future<AppState?> reduce() async {
    await TaskApi().update(id, task);

    return null;
  }
}

class EditTask extends ReduxAction<AppState> {
  EditTask({this.task});

  final TaskModel? task;

  @override
  AppState? reduce() => state.copyWith.taskState(newTask: task);
}
