import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample/apis/tasks_api/models/task_model.dart';
import 'package:firebase_sample/utilities/enums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        return Colors.blue;
      case TicketType.CHANGE_REQUEST:
        return Colors.green;
    }
  }

  String get stringValue {
    switch (this) {
      case TicketType.BUG:
        return 'Bug';
      case TicketType.TASK:
        return 'Task';
      case TicketType.CHANGE_REQUEST:
        return 'Change Request';
    }
  }

  IconData get icon {
    switch (this) {
      case TicketType.BUG:
        return Icons.bug_report;
      case TicketType.TASK:
        return Icons.task;
      case TicketType.CHANGE_REQUEST:
        return Icons.replay_circle_filled;
    }
  }
}

extension TaskProgressExt on TaskProgress {
  String get stringValue {
    switch (this) {
      case TaskProgress.TODO:
        return 'TO DO';
      case TaskProgress.IN_PROGRESS:
        return 'In progress';
      case TaskProgress.IN_TESTING:
        return 'In testing';
      case TaskProgress.DONE:
        return 'Approved';
    }
  }

  IconData get icon {
    switch (this) {
      case TaskProgress.TODO:
        return Icons.checklist;
      case TaskProgress.IN_PROGRESS:
        return Icons.edit;
      case TaskProgress.IN_TESTING:
        return Icons.approval;
      case TaskProgress.DONE:
        return Icons.done;
    }
  }
}

extension PriorityLevelExt on PriorityLevel {
  Color get color {
    switch (this) {
      case PriorityLevel.LOW:
        return Colors.green;
      case PriorityLevel.MEDIUM:
        return Colors.yellow;
      case PriorityLevel.HIGH:
        return Colors.orange;
      case PriorityLevel.URGENT:
        return Colors.red;
    }
  }

  String get stringValue {
    switch (this) {
      case PriorityLevel.LOW:
        return 'Low';
      case PriorityLevel.MEDIUM:
        return 'Medium';
      case PriorityLevel.HIGH:
        return 'High';
      case PriorityLevel.URGENT:
        return 'Urgent';
    }
  }
}

extension DateTimeExt on DateTime {
  String format(String dateFormat) => DateFormat(dateFormat).format(this);
}
