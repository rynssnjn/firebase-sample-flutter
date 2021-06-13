import 'package:async_redux/async_redux.dart';
import 'package:firebase_sample/features/login_page/login_page_widget.dart';
import 'package:firebase_sample/features/tasks_board/task_board_connector.dart';
import 'package:firebase_sample/state/actions/user_actions.dart';
import 'package:firebase_sample/state/app_state.dart';
import 'package:flutter/material.dart';

class LoginPageVM extends BaseModel<AppState> {
  LoginPageVM();

  LoginPageVM.build({
    this.onLogin,
    this.onRegister,
    this.isLoggedInEvt,
  }) : super(equals: [isLoggedInEvt]);

  Future<void> Function(String email, String password)? onLogin;
  Future<void> Function(String email, String password, String firstname, String surname)? onRegister;
  Event<bool>? isLoggedInEvt;

  @override
  BaseModel fromStore() {
    return LoginPageVM.build(
      onLogin: _onLogin,
      onRegister: _onRegister,
      isLoggedInEvt: state.userState.isLoggedInEvt,
    );
  }

  Future<void> _onLogin(String email, String password) async => await dispatchFuture!(LoginUser(email, password));

  Future<void> _onRegister(String email, String password, String firstname, String surname) async =>
      await dispatchFuture!(RegisterUser(email, password, firstname, surname));
}

class LoginPageConnector extends StatelessWidget {
  static const route = 'login-page';

  const LoginPageConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginPageVM>(
      model: LoginPageVM(),
      onDidChange: (c, __, vm) {
        if (vm.isLoggedInEvt?.consume() == true) {
          Navigator.pushReplacementNamed(c, TaskBoardConnector.route);
        }
      },
      builder: (context, vm) => LoginPageWidget(
        onLogin: vm.onLogin!,
        onRegister: vm.onRegister!,
      ),
    );
  }
}
