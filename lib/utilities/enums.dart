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
