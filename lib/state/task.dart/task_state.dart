import 'package:firebase_sample/apis/tasks_api/models/task_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_state.freezed.dart';

part 'task_state.g.dart';

@freezed
abstract class TaskState with _$TaskState {
  factory TaskState({
    @JsonKey(name: 'newTask') TaskModel? newTask,
  }) = _TaskState;

  factory TaskState.fromJson(Map<String, dynamic> json) => _$TaskStateFromJson(json);

  factory TaskState.init() => TaskState();
}
