import 'package:json_annotation/json_annotation.dart';

enum TaskProgress {
  @JsonValue(0)
  TODO,
  @JsonValue(1)
  IN_PROGRESS,
  @JsonValue(2)
  IN_TESTING,
  @JsonValue(3)
  DONE
}

enum TicketType {
  @JsonValue(0)
  BUG,
  @JsonValue(1)
  TASK,
  @JsonValue(2)
  CHANGE_REQUEST
}

enum PriorityLevel {
  @JsonValue(0)
  LOW,
  @JsonValue(1)
  MEDIUM,
  @JsonValue(2)
  HIGH,
  @JsonValue(3)
  URGENT,
}

enum TaskAction { CREATE, EDIT }
