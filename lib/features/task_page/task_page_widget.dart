import 'package:firebase_sample/apis/tasks_api/models/task_model.dart';
import 'package:firebase_sample/models/union_task_form.dart';
import 'package:firebase_sample/utilities/enums.dart';
import 'package:firebase_sample/utilities/extensions.dart';
import 'package:firebase_sample/widgets/app_dropdown.dart';
import 'package:firebase_sample/widgets/app_text_field.dart';
import 'package:firebase_sample/widgets/loading_widget.dart';
import 'package:firebase_sample/widgets/widget_spacer.dart';
import 'package:flutter/material.dart';

class TaskPageWidget extends StatefulWidget {
  const TaskPageWidget({
    required this.onSaveTask,
    required this.onUpdateTask,
    required this.onDeleteTask,
    required this.onEditTask,
    this.task,
    this.action,
    Key? key,
  }) : super(key: key);

  final Future<void> Function() onSaveTask;
  final Future<void> Function() onUpdateTask;
  final Future<void> Function() onDeleteTask;
  final Function(UnionTaskForm form)? onEditTask;
  final TaskModel? task;
  final TaskAction? action;

  @override
  _TaskPageWidgetState createState() => _TaskPageWidgetState();
}

class _TaskPageWidgetState extends State<TaskPageWidget> {
  TicketType? ticketType;
  PriorityLevel? priorityLevel;
  TaskProgress? taskProgress;
  TextEditingController? titleContoller;
  TextEditingController? descriptionController;

  @override
  void initState() {
    ticketType = widget.task!.type;
    priorityLevel = widget.task!.priority;
    taskProgress = widget.task!.progress;
    titleContoller = TextEditingController(text: widget.task!.title ?? '');
    descriptionController = TextEditingController(text: widget.task!.description ?? '');
    super.initState();
  }

  @override
  void dispose() {
    titleContoller!.dispose();
    descriptionController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hintStyle = textTheme.bodyText2!.copyWith(color: Colors.grey);
    return GestureDetector(
      onTap: () {
        final focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) focus.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(widget.action == TaskAction.EDIT ? widget.task!.title! : 'Add Task'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 32,
          ),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 32,
                left: 16,
                right: 16,
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  if (widget.action == TaskAction.EDIT) ...[
                    AppTextField(
                      initialValue: widget.task!.creationDate!.format('yMMMMEEEEd'),
                      hintText: 'Description goes here...',
                      hintTextStyle: hintStyle,
                      inputTextStyle: textTheme.bodyText2,
                      helperText: 'Creation date',
                      readonly: true,
                    ),
                    VerticalSpacer(15),
                    AppDropdown<TaskProgress>(
                      value: taskProgress,
                      items: TaskProgress.values,
                      onChanged: (progress) {
                        widget.onEditTask!(UnionTaskForm.progress(progress));
                        setState(() => taskProgress = progress);
                      },
                      isRequired: true,
                      textBuilder: (type) => type.stringValue,
                      hintText: 'TO DO',
                      hintTextStyle: textTheme.bodyText2,
                      helperText: 'Move to:',
                    ),
                    VerticalSpacer(15),
                  ],
                  AppTextField(
                    controller: titleContoller,
                    hintText: 'Title goes here...',
                    hintTextStyle: hintStyle,
                    isRequired: true,
                    textInputAction: TextInputAction.next,
                    inputTextStyle: textTheme.bodyText2,
                    helperText: 'Task Title',
                    onChangedHandler: (text) => widget.onEditTask!(UnionTaskForm.title(text)),
                  ),
                  VerticalSpacer(15),
                  AppTextField(
                    controller: descriptionController,
                    hintText: 'Description goes here...',
                    hintTextStyle: hintStyle,
                    keyboardType: TextInputType.multiline,
                    isRequired: true,
                    textInputAction: TextInputAction.newline,
                    inputTextStyle: textTheme.bodyText2,
                    helperText: 'Task Description',
                    onChangedHandler: (text) => widget.onEditTask!(UnionTaskForm.description(text)),
                  ),
                  VerticalSpacer(15),
                  AppDropdown<TicketType>(
                    value: ticketType,
                    items: TicketType.values,
                    onChanged: (type) {
                      widget.onEditTask!(UnionTaskForm.type(type));
                      setState(() => ticketType = type);
                    },
                    isRequired: true,
                    textBuilder: (type) => type.stringValue,
                    hintText: 'Type',
                    hintTextStyle: textTheme.bodyText2,
                    helperText: 'Ticket Type',
                  ),
                  VerticalSpacer(15),
                  AppDropdown<PriorityLevel>(
                    value: priorityLevel,
                    items: PriorityLevel.values,
                    onChanged: (priority) {
                      widget.onEditTask!(UnionTaskForm.priority(priority));
                      setState(() => priorityLevel = priority);
                    },
                    isRequired: true,
                    textBuilder: (type) => type.stringValue,
                    hintText: 'Priority',
                    hintTextStyle: textTheme.bodyText2,
                    helperText: 'Priority Level',
                  ),
                  VerticalSpacer(35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.action == TaskAction.EDIT) ...[
                        LoadingWidget(
                          futureCallback: () async {
                            await widget.onDeleteTask();
                            Navigator.pop(context);
                          },
                          renderChild: (isLoading, onTap) => isLoading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2.0),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(primary: Colors.red),
                                  onPressed: onTap,
                                  child: Text('Delete'),
                                ),
                        ),
                        HorizontalSpacer(10),
                      ],
                      LoadingWidget(
                        futureCallback: () async {
                          if (widget.action == TaskAction.CREATE) {
                            await widget.onSaveTask();
                          } else {
                            await widget.onUpdateTask();
                          }
                          Navigator.pop(context);
                        },
                        renderChild: (isLoading, onTap) => isLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2.0),
                              )
                            : ElevatedButton(
                                onPressed: onTap,
                                child: Text('Save'),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
