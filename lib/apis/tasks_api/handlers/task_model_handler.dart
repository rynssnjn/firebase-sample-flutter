import 'package:firebase_sample/apis/tasks_api/models/task_model.dart';
import 'package:firebase_sample/utilities/app_starter.dart';

const String collectionPath = 'tasks';

class TaskApi {
  Future create(TaskModel body) async {
    return await firestoreInstance.collection(collectionPath).add(body.toJson());
  }

  Future update(String id, TaskModel body) async {
    return await firestoreInstance.collection(collectionPath).doc(id).update(body.toJson());
  }
}
