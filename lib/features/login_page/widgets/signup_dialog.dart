import 'package:firebase_sample/widgets/app_text_field.dart';
import 'package:firebase_sample/widgets/icon_dialog.dart';
import 'package:firebase_sample/widgets/loading_button_widget.dart';
import 'package:firebase_sample/widgets/widget_spacer.dart';
import 'package:flutter/material.dart';

class SignupDialog extends StatefulWidget {
  const SignupDialog({
    required this.onRegister,
    Key? key,
  }) : super(key: key);

  final Future<void> Function(String email, String password, String firstname, String surname) onRegister;

  @override
  _SignupDialogState createState() => _SignupDialogState();
}

class _SignupDialogState extends State<SignupDialog> {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? firstnameController;
  TextEditingController? surnameController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    firstnameController = TextEditingController();
    surnameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController!.dispose();
    passwordController!.dispose();
    firstnameController!.dispose();
    surnameController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hintStyle = textTheme.bodyText2!.copyWith(color: Colors.grey);
    return IconDialog(
      content: ListView(
        shrinkWrap: true,
        children: [
          AppTextField(
            controller: emailController,
            hintText: 'sample@email.com',
            hintTextStyle: hintStyle,
            inputTextStyle: textTheme.bodyText2,
            helperText: 'Email',
            isRequired: true,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
          ),
          VerticalSpacer(15),
          AppTextField(
            controller: passwordController,
            hintText: 'Password goes here.',
            hintTextStyle: hintStyle,
            inputTextStyle: textTheme.bodyText2,
            helperText: 'Password',
            isRequired: true,
            textInputAction: TextInputAction.next,
            isPassword: true,
          ),
          AppTextField(
            controller: firstnameController,
            hintText: 'Tony',
            hintTextStyle: hintStyle,
            inputTextStyle: textTheme.bodyText2,
            helperText: 'First name',
            isRequired: true,
            textInputAction: TextInputAction.next,
            capitalization: TextCapitalization.words,
          ),
          VerticalSpacer(15),
          AppTextField(
            controller: surnameController,
            hintText: 'Stark',
            hintTextStyle: hintStyle,
            inputTextStyle: textTheme.bodyText2,
            helperText: 'Surname',
            isRequired: true,
            textInputAction: TextInputAction.done,
            capitalization: TextCapitalization.words,
          ),
          VerticalSpacer(25),
          LoadingButtonWidget(
            futureCallback: () async {
              await widget.onRegister(
                emailController!.text,
                passwordController!.text,
                firstnameController!.text,
                surnameController!.text,
              );
              Navigator.pop(context);
            },
            text: 'Sign up',
          )
        ],
      ),
      icon: Icons.create,
    );
  }
}
