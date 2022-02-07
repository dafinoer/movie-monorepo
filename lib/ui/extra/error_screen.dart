import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final double fontSize;
  final double gap;
  final Widget? retryButton;
  final String? message;
  final Function()? retry;
  final Color? textColor;

  const ErrorScreen({
    Key? key,
    this.fontSize = 14,
    this.gap = 10,
    this.retryButton,
    this.message,
    this.retry,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final message = this.message;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (message != null)
              Text(
                message,
                style:
                    TextStyle(fontSize: 12, color: textColor ?? Colors.black),
              ),
            if (retry != null)
              Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  retryButton ??
                      IconButton(
                        onPressed: retry,
                        icon: Icon(Icons.refresh_sharp),
                      ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
