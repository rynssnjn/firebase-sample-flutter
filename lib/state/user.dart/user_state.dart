import 'package:async_redux/async_redux.dart';
import 'package:firebase_sample/apis/users_api/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

part 'user_state.g.dart';

@freezed
abstract class UserState with _$UserState {
  factory UserState({
    @JsonKey(name: 'isLoggedIn') required bool isLoggedIn,
    @JsonKey(name: 'onLoggedInEvt', ignore: true) Event<bool>? onLoggedInEvt,
    @JsonKey(name: 'user') UserModel? user,
  }) = _UserState;

  factory UserState.fromJson(Map<String, dynamic> json) => _$UserStateFromJson(json);

  factory UserState.init() => UserState(isLoggedIn: false);
}
