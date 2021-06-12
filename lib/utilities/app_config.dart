import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample/utilities/app_starter.dart';

class AppConfig {
  static final AppConfig _instance = AppConfig._internal();

  factory AppConfig() => _instance;

  AppConfig._internal();

  final _Config _config = _Config.dev();

  CollectionReference<Map<String, dynamic>> get taskCollection => _config.taskCollection;
}

class _Config {
  _Config._({
    required this.taskCollection,
  });

  factory _Config.dev() => _Config._(
        taskCollection: firestoreInstance.collection('tasks'),
      );

  final CollectionReference<Map<String, dynamic>> taskCollection;
}
