import 'package:firebase_sample/utilities/colors.dart';
import 'package:firebase_sample/widgets/app_text_field.dart';
import 'package:firebase_sample/widgets/loading_widget.dart';
import 'package:firebase_sample/widgets/widget_spacer.dart';
import 'package:flutter/material.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({
    required this.onLogin,
    Key? key,
  }) : super(key: key);

  final Future<void> Function(String email, String password) onLogin;

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
      ),
      body: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 32,
              ),
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                gradient: snowGrand,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 10),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  AppTextField(
                    controller: emailController,
                    hintText: 'sample@email.com',
                    hintTextStyle: hintStyle,
                    inputTextStyle: textTheme.bodyText2,
                    helperText: 'Email',
                    isRequired: true,
                    isEmail: true,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                  ),
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
                  LoadingWidget(
                    futureCallback: () async => await widget.onLogin(emailController!.text, passwordController!.text),
                    renderChild: (isLoading, onTap) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      ),
                      onPressed: onTap,
                      child: isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              child: CircleAvatar(
                backgroundColor: Colors.green,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.lock,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
