import 'package:firebase_sample/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class LoadingButtonWidget extends StatelessWidget {
  const LoadingButtonWidget({
    required this.futureCallback,
    this.text,
    this.color = Colors.green,
    Key? key,
  }) : super(key: key);

  final Future<void> Function() futureCallback;
  final String? text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      futureCallback: futureCallback,
      renderChild: (isLoading, onTap) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
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
            : Text(text!),
      ),
    );
  }
}
