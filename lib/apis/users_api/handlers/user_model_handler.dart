import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/apis/users_api/models/user_model.dart';

class UserApi {
  UserApi(this.auth, this.collection);

  final FirebaseAuth auth;

  final CollectionReference<Map<String, dynamic>> collection;

  Future<UserModel> getUserByUid(String uid) async {
    final users = await collection.get().then(
          (value) => value.docs.map((e) {
            final decoded = jsonDecode(jsonEncode(e.data()));
            return UserModel.fromJson(decoded);
          }).toList(),
        );
    return users.firstWhere((user) => user.uid == uid);
  }

  Future<UserModel> login(String email, String password) async {
    final credentials = await auth.signInWithEmailAndPassword(email: email, password: password);
    final users = await collection.get().then(
          (value) => value.docs.map((e) {
            final decoded = jsonDecode(jsonEncode(e.data()));
            return UserModel.fromJson(decoded);
          }).toList(),
        );

    return users.firstWhere((user) => user.uid == credentials.user!.uid);
  }

  Future<UserCredential> register(String email, String password) async {
    return await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<UserModel> createUser(UserModel body) async {
    final reference = await collection.add(body.toJson());
    return await collection.doc(reference.id).get().then((value) {
      final decoded = jsonDecode(jsonEncode(value.data()));
      return UserModel.fromJson(decoded);
    });
  }

  Future logout() async {
    return await auth.signOut();
  }
}
