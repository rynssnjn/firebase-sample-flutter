import 'package:firebase_sample/utilities/enums.dart';
import 'package:firebase_sample/utilities/extensions.dart';
import 'package:firebase_sample/widgets/app_dropdown.dart';
import 'package:firebase_sample/widgets/app_text_field.dart';
import 'package:firebase_sample/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({
    required this.onAddTask,
    required this.onChangeTitle,
    required this.onChangeDescription,
    required this.onChangeTicketType,
    this.type,
    Key? key,
  }) : super(key: key);

  final Future<void> Function() onAddTask;
  final Function(String text) onChangeTitle;
  final Function(String text) onChangeDescription;
  final Function(TicketType? type) onChangeTicketType;
  final TicketType? type;

  @override
  _AddTaskWidgetState createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  TicketType? ticketType;
  TextEditingController? titleContoller;
  TextEditingController? descriptionController;

  @override
  void initState() {
    ticketType = widget.type;
    titleContoller = TextEditingController();
    descriptionController = TextEditingController();
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
    return GestureDetector(
      onTap: () {
        final focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) focus.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: Text('Add Task')),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 32,
          ),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 16,
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  AppDropdown<TicketType>(
                    value: ticketType,
                    items: TicketType.values,
                    onChanged: (type) {
                      widget.onChangeTicketType(type);
                      setState(() => ticketType = type);
                    },
                    isRequired: true,
                    textBuilder: (type) => type.stringValue,
                    hintText: 'Type',
                    hintTextStyle: textTheme.bodyText1,
                    helperText: 'Ticket Type',
                  ),
                  AppTextField(
                    controller: titleContoller,
                    hintText: 'Title',
                    hintTextStyle: textTheme.bodyText1!.copyWith(color: Colors.grey),
                    isRequired: true,
                    textInputAction: TextInputAction.next,
                    inputTextStyle: textTheme.bodyText1,
                    helperText: 'Task Title',
                    onChangedHandler: widget.onChangeTitle,
                  ),
                  AppTextField(
                    controller: descriptionController,
                    hintText: 'Description',
                    hintTextStyle: textTheme.bodyText1!.copyWith(color: Colors.grey),
                    keyboardType: TextInputType.multiline,
                    isRequired: true,
                    textInputAction: TextInputAction.newline,
                    inputTextStyle: textTheme.bodyText1,
                    helperText: 'Task Description',
                    onChangedHandler: widget.onChangeDescription,
                  ),
                  Center(
                    child: LoadingWidget(
                      futureCallback: () async {
                        await widget.onAddTask();
                        Navigator.pop(context);
                      },
                      renderChild: (isLoading, onTap) => isLoading
                          ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: onTap,
                              child: Text('Save to Database'),
                            ),
                    ),
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
