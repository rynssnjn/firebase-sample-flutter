import 'package:firebase_sample/apis/test_api/models/test_model.dart';
import 'package:firebase_sample/utilities/app_starter.dart';

const String collectionPath = 'TEST';

class TestApi {
  Future<List<TestModel?>?> getTests() async {
    return await firestoreInstance.collection(collectionPath).get().then((snapshot) {
      return snapshot.docs.map((e) => TestModel.fromJson(e.data())).toList();
    });
  }

  Future addTest(TestModel test) async {
    return await firestoreInstance.collection(collectionPath).add(test.toJson());
  }
}
