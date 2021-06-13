import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:firebase_sample/apis/api_service.dart';
import 'package:firebase_sample/apis/tasks_api/models/task_model.dart';
import 'package:firebase_sample/state/app_state.dart';
import 'package:firebase_sample/utilities/enums.dart';

class InitTask extends ReduxAction<AppState> {
  InitTask({this.task});

  final TaskModel? task;

  @override
  AppState? reduce() {
    final model = TaskModel(
      title: '',
      description: '',
      type: TicketType.BUG,
      progress: TaskProgress.TODO,
      priority: PriorityLevel.LOW,
      creationDate: DateTime.now(),
      creator: state.userState.user,
    );
    return state.copyWith.taskState(task: task ?? model);
  }
}

class AddTask extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    await ApiService().taskApi.create(state.taskState.task!);

    return null;
  }
}

class UpdateTask extends ReduxAction<AppState> {
  UpdateTask(this.id, this.task);

  final String id;
  final TaskModel task;

  @override
  Future<AppState?> reduce() async {
    await ApiService().taskApi.update(id, task);

    return null;
  }
}

class DeleteTask extends ReduxAction<AppState> {
  DeleteTask(this.id);

  final String id;

  @override
  Future<AppState?> reduce() async {
    await ApiService().taskApi.delete(id);

    return null;
  }
}

class EditTask extends ReduxAction<AppState> {
  EditTask({this.task});

  final TaskModel? task;

  @override
  AppState? reduce() => state.copyWith.taskState(task: task);
}
