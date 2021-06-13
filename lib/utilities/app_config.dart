import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/utilities/app_starter.dart';

class AppConfig {
  static final AppConfig _instance = AppConfig._internal();

  factory AppConfig() => _instance;

  AppConfig._internal();

  final _Config _config = _Config.dev();

  CollectionReference<Map<String, dynamic>> get taskCollection => _config.taskCollection;

  CollectionReference<Map<String, dynamic>> get userCollection => _config.userCollection;

  FirebaseAuth get firebaseAuth => _config.firebaseAuth;
}

class _Config {
  _Config._({
    required this.taskCollection,
    required this.userCollection,
    required this.firebaseAuth,
  });

  factory _Config.dev() => _Config._(
        taskCollection: firestoreInstance.collection('tasks'),
        userCollection: firestoreInstance.collection('users'),
        firebaseAuth: FirebaseAuth.instance,
      );

  final CollectionReference<Map<String, dynamic>> taskCollection;
  final CollectionReference<Map<String, dynamic>> userCollection;
  final FirebaseAuth firebaseAuth;
}
