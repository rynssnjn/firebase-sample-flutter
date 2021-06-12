import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:firebase_sample/apis/api_service.dart';
import 'package:firebase_sample/apis/users_api/models/user_model.dart';
import 'package:firebase_sample/state/actions/actions.dart';
import 'package:firebase_sample/state/app_state.dart';

class CheckAuthentication extends ReduxAction<AppState> {
  @override
  AppState? reduce() {
    final isLoggedIn = ApiService().userApi.auth.currentUser != null;

    return state.copyWith.userState(isLoggedIn: isLoggedIn);
  }
}

class LoginUser extends LoginAction {
  LoginUser(
    this.email,
    this.password,
  );

  final String email;
  final String password;

  bool succeed = true;

  @override
  Future<AppState?> reduce() async {
    final user = await ApiService().userApi.login(email, password);

    return state.copyWith.userState(user: user);
  }
}

class RegisterUser extends LoginAction {
  RegisterUser(
    this.email,
    this.password,
    this.firstname,
    this.surname,
  );

  final String email;
  final String password;
  final String firstname;
  final String surname;

  @override
  Future<AppState?> reduce() async {
    final credentials = await ApiService().userApi.register(email, password);

    final newUser = UserModel(
      firstname: firstname,
      surname: surname,
      email: credentials.user!.email,
      uid: credentials.user!.uid,
    );

    final user = await ApiService().userApi.createUser(newUser);

    return state.copyWith.userState(user: user);
  }
}

class LogoutUser extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    await ApiService().userApi.logout();

    return AppState.init();
  }
}

class UpdateLoginEvent extends ReduxAction<AppState> {
  UpdateLoginEvent(this.isLoggedIn);

  final bool isLoggedIn;

  @override
  AppState? reduce() => state.copyWith.userState(onLoggedInEvt: Event(true));

  @override
  Object? wrapError(error) {
    print(error);
    return super.wrapError(error);
  }
}
