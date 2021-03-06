import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/state/actions/user_actions.dart';
import 'package:firebase_sample/state/app_state.dart';

abstract class LoginAction extends ReduxAction<AppState> {
  bool requestSucceed = true;

  @override
  void after() {
    if (requestSucceed) {
      dispatch(UpdateLoginEvent(requestSucceed));
    }
    super.after();
  }

  @override
  Object? wrapError(error) {
    requestSucceed = false;
    if (error is FirebaseAuthException) {
      return UserException(error.message);
    }
    return super.wrapError(error);
  }
}
