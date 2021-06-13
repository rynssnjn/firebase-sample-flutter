import 'package:firebase_sample/features/login_page/widgets/signup_dialog.dart';
import 'package:firebase_sample/utilities/colors.dart';
import 'package:firebase_sample/widgets/app_text_field.dart';
import 'package:firebase_sample/widgets/icon_dialog.dart';
import 'package:firebase_sample/widgets/loading_button_widget.dart';
import 'package:firebase_sample/widgets/widget_spacer.dart';
import 'package:flutter/material.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({
    required this.onLogin,
    required this.onRegister,
    Key? key,
  }) : super(key: key);

  final Future<void> Function(String email, String password) onLogin;
  final Future<void> Function(String email, String password, String firstname, String surname) onRegister;

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController!.dispose();
    passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hintStyle = textTheme.bodyText2!.copyWith(color: Colors.grey);
    return Scaffold(
      backgroundColor: lightGrey,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Login'),
        actions: [
          IconButton(
            onPressed: () => showDialog(context: context, builder: (c) => SignupDialog(onRegister: widget.onRegister)),
            icon: Icon(Icons.create),
            tooltip: 'Sign up',
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: lightGradientBackground),
        child: IconDialog(
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
                textInputAction: TextInputAction.done,
                isPassword: true,
              ),
              VerticalSpacer(25),
              LoadingButtonWidget(
                futureCallback: () async => await widget.onLogin(emailController!.text, passwordController!.text),
                text: 'Login',
              )
            ],
          ),
          icon: Icons.lock,
        ),
      ),
    );
  }
}
