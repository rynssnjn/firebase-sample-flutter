import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample/apis/tasks_api/models/task_model.dart';
import 'package:firebase_sample/utilities/enums.dart';
import 'package:flutter/material.dart';

extension QueryDocumentSnapshotExt on QueryDocumentSnapshot<Object?> {
  Map<String, dynamic>? get decoded => jsonDecode(jsonEncode(data()));

  TaskModel get toTask => TaskModel.fromJson(decoded!);
}

extension TicketTypeExt on TicketType {
  Color get color {
    switch (this) {
      case TicketType.BUG:
        return Colors.red;
      case TicketType.TASK:
        return Colors.blueAccent;
      case TicketType.CHANGE_REQUEST:
        return Colors.greenAccent;
    }
  }
}

extension TaskProgressExt on TaskProgress {
  String get stringValue {
    switch (this) {
      case TaskProgress.TODO:
        return 'TODO';
      case TaskProgress.IN_PROGRESS:
        return 'In progress';
      case TaskProgress.IN_TESTING:
        return 'In testing';
      case TaskProgress.DONE:
        return 'Approved';
    }
  }
}
