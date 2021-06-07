import 'package:firebase_sample/state/task.dart/task_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

part 'app_state.g.dart';

@freezed
abstract class AppState with _$AppState {
  factory AppState({
    @JsonKey(name: 'taskState') required TaskState taskState,
  }) = _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);

  factory AppState.init() => AppState(taskState: TaskState.init());
}
