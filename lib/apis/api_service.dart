import 'package:firebase_sample/apis/tasks_api/handlers/task_model_handler.dart';
import 'package:firebase_sample/utilities/app_config.dart';

class ApiService {
  TaskApi get taskApi => TaskApi(AppConfig().taskCollection);
}
