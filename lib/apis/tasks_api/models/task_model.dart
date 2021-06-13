import 'dart:convert';

import 'package:firebase_sample/apis/users_api/models/user_model.dart';
import 'package:firebase_sample/utilities/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

extension TaskModelExt on TaskModel {
  Map<String, dynamic> decodeToJson() => jsonDecode(jsonEncode(this));
}

@freezed
abstract class TaskModel with _$TaskModel {
  factory TaskModel({
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'progress') TaskProgress? progress,
    @JsonKey(name: 'type') TicketType? type,
    @JsonKey(name: 'priority') PriorityLevel? priority,
    @JsonKey(name: 'creationDate') DateTime? creationDate,
    @JsonKey(name: 'creator') UserModel? creator,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);
}
