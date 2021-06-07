import 'package:async_redux/async_redux.dart';
import 'package:firebase_sample/apis/test_api/models/test_model.dart';
import 'package:firebase_sample/state/actions/actions.dart';
import 'package:firebase_sample/state/app_state.dart';

import 'home_page_connector.dart';

class TryViewModel extends Vm {
  TryViewModel({
    this.onAddData,
  }) : super(equals: []);

  final Future<void> Function(TestModel data)? onAddData;
}

class TryViewModelFactory extends VmFactory<AppState, HomePageConnector> {
  TryViewModelFactory(HomePageConnector widget) : super(widget);

  @override
  Vm fromStore() => TryViewModel(
        onAddData: onAddData,
      );

  Future<void> onAddData(TestModel data) async => await dispatchFuture(AddData(data: data));
}
