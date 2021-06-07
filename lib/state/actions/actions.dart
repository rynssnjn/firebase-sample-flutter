import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:firebase_sample/apis/test_api/handlers/test_model_handler.dart';
import 'package:firebase_sample/apis/test_api/models/test_model.dart';
import 'package:firebase_sample/state/app_state.dart';

class AddData extends ReduxAction<AppState> {
  AddData({this.data});

  final TestModel? data;

  @override
  Future<AppState?> reduce() async {
    await TestApi().addTest(data!);

    return null;
  }
}

class GetData extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    final tests = await TestApi().getTests();
    tests?.forEach((element) {
      print('name: ${element?.name}');
      print('age: ${element?.age}');
    });
    return null;
  }
}
