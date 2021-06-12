import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample/apis/tasks_api/models/task_model.dart';

class TaskApi {
  TaskApi(this.collection);

  final CollectionReference<Map<String, dynamic>> collection;

  Future create(TaskModel body) async {
    return await collection.add(body.toJson());
  }

  Future update(String id, TaskModel body) async {
    return await collection.doc(id).update(body.toJson());
  }

  Future delete(String id) async {
    return await collection.doc(id).delete();
  }
}
