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
    this.onLoggedInEvt,
  }) : super(equals: [onLoggedInEvt]);

  Future<void> Function(String email, String password)? onLogin;
  Event<bool>? onLoggedInEvt;

  @override
  BaseModel fromStore() {
    return LoginPageVM.build(
      onLogin: _onLogin,
      onLoggedInEvt: state.userState.onLoggedInEvt,
    );
  }

  Future<void> _onLogin(String email, String password) async => await dispatchFuture!(LoginUser(email, password));
}

class LoginPageConnector extends StatelessWidget {
  static const route = 'login-page';

  const LoginPageConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginPageVM>(
      model: LoginPageVM(),
      onDidChange: (c, __, vm) {
        if (vm.onLoggedInEvt?.consume() == true) {
          Navigator.pushReplacementNamed(c, TaskBoardConnector.route);
        }
      },
      builder: (context, vm) => LoginPageWidget(onLogin: vm.onLogin!),
    );
  }
}
