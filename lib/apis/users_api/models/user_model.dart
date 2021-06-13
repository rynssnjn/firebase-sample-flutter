import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

extension UserModelExt on UserModel {
  String get fullName => '$firstname $surname';

  String get fullNameSurnameFirst => '$surname, $firstname';
}

@freezed
abstract class UserModel with _$UserModel {
  factory UserModel({
    @JsonKey(name: 'firstname') String? firstname,
    @JsonKey(name: 'surname') String? surname,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'uid') String? uid,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
