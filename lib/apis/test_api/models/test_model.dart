import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_model.freezed.dart';
part 'test_model.g.dart';

@freezed
abstract class TestModel with _$TestModel {
  factory TestModel({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'age') int? age,
  }) = _TestModel;

  factory TestModel.fromJson(Map<String, dynamic> json) => _$TestModelFromJson(json);
}
