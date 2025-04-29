import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LinkButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? color;
  static double defaultFontSize = 14;

  const LinkButton({super.key, required this.text, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Text(
        text,
        // style:
        // CustomTextTheme.getTextStyle(MyTextStyle.LinkTextButton, context),
        style: TextStyle(
          color: color ?? Colors.blue, //AppTheme.primaryColor,
          fontSize: defaultFontSize,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }
}
