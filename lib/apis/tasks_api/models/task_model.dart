import 'package:firebase_sample/utilities/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
abstract class TaskModel with _$TaskModel {
  factory TaskModel({
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'progress') TaskProgress? progress,
    @JsonKey(name: 'type') TicketType? type,
    @JsonKey(name: 'priority') PriorityLevel? priority,
    @JsonKey(name: 'creationDate') DateTime? creationDate,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);
}
