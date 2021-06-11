import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_sample/state/app_state.dart';
import 'package:firebase_sample/test_app.dart';
import 'package:flutter/material.dart';

final firestoreInstance = FirebaseFirestore.instance;
final CollectionReference<Map<String, dynamic>> tasks = firestoreInstance.collection('tasks');

void startApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final store = Store<AppState>(initialState: AppState.init());
  runApp(TestApp(store: store));
}
