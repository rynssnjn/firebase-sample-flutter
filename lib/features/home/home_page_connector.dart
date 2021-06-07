import 'package:async_redux/async_redux.dart';
import 'package:firebase_sample/features/home/home_page_widget.dart';
import 'package:firebase_sample/state/actions/actions.dart';
import 'package:firebase_sample/state/app_state.dart';
import 'package:firebase_sample/features/home/try_vm.dart';
import 'package:flutter/material.dart';

class HomePageConnector extends StatelessWidget {
  static const route = 'home';

  final nameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TryViewModel>(
      onInit: (store) => store.dispatch(GetData()),
      onDispose: (store) {
        nameController.dispose();
        ageController.dispose();
      },
      vm: () => TryViewModelFactory(this),
      builder: (context, vm) => HomePageWidget(
        onAddData: vm.onAddData,
        nameController: nameController,
        ageController: ageController,
      ),
    );
  }
}
