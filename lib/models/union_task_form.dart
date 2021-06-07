import 'package:freezed_annotation/freezed_annotation.dart';

part 'union_task_form.freezed.dart';

@freezed
abstract class UnionTaskForm with _$UnionTaskForm {
  const factory UnionTaskForm.title([String? title]) = Title;
  const factory UnionTaskForm.description([String? description]) = Description;
}
