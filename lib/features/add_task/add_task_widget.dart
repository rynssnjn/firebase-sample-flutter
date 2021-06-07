import 'package:firebase_sample/widgets/app_text_field.dart';
import 'package:firebase_sample/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class AddTaskWidget extends StatelessWidget {
  const AddTaskWidget({
    required this.onAddTask,
    required this.onChangeTitle,
    required this.onChangeDescription,
    Key? key,
  }) : super(key: key);

  final Future<void> Function() onAddTask;
  final Function(String text) onChangeTitle;
  final Function(String text) onChangeDescription;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Add Task')),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 32,
        ),
        child: Card(
          clipBehavior: Clip.hardEdge,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 32,
              horizontal: 16,
            ),
            child: Column(
              children: [
                AppTextField(
                  hintText: 'Title',
                  hintTextStyle: textTheme.bodyText1!.copyWith(fontSize: 15),
                  isRequired: true,
                  textInputAction: TextInputAction.next,
                  inputTextStyle: textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w400),
                  helperText: 'Task Title',
                  onChangedHandler: onChangeTitle,
                ),
                AppTextField(
                  hintText: 'Description',
                  hintTextStyle: textTheme.bodyText1!.copyWith(fontSize: 15),
                  isRequired: true,
                  textInputAction: TextInputAction.done,
                  inputTextStyle: textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w400),
                  helperText: 'Task Description',
                  onChangedHandler: onChangeDescription,
                ),
                Spacer(),
                Center(
                  child: LoadingWidget(
                    futureCallback: () async {
                      await onAddTask();
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
    );
  }
}
