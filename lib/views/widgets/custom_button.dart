import 'package:flutter/material.dart';
import 'package:practice_backend/utils/utils.dart';
// import '/theme/app_theme.dart';
// import '/theme/dashboard_font_size.dart';
// import '/util/utils.dart';
import '../../utils/theme_size.dart';

class CustomButton extends StatelessWidget {
  final double defaultFontSize = 16;
  final String text;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  // bool showloading = true;

  // final Color? backgroundColor;
  // final Color? textColor;

  CustomButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.textColor,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: Utils.isTablet(context)
            ? ThemeSize.themeButtonSize + 10
            : ThemeSize.themeButtonSize,
        width: double.infinity,
        // child: ElevatedButton(
        padding: EdgeInsets.all(10.0),
        // onPressed: () {},
        child: Text(
          text,
          style: TextStyle(
              color: textColor ?? Colors.white, //AppTheme.primaryButtonText!,
              fontSize: defaultFontSize),
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          borderRadius:
              BorderRadius.all(Radius.circular(ThemeSize.themeBorderRadius)),
          color: backgroundColor ?? Colors.black, //// AppTheme
          //     .primaryButtonBackground // ?? AppColors.accent, // Color(0xFFF2F3F7)
        ),
      ),
    );
  }
}
