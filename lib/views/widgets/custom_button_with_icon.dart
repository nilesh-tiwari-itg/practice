import 'package:flutter/material.dart';
// import '/theme/app_theme.dart';
import '../../utils/theme_size.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final double defaultFontSize = 16;
  final String text;
  final Function()? onPressed;
  final String svgImage;
  // bool showloading = true;
  final Color? backgroundColor;
  final Color? textColor;

  CustomButtonWithIcon(this.svgImage,
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
        height: ThemeSize.themeButtonSize,
        width: double.infinity,
        // child: ElevatedButton(
        padding: EdgeInsets.all(10.0),
        // onPressed: () {},
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.05,
            height: MediaQuery.of(context).size.width * 0.08,
            child: SvgPicture.asset(svgImage!,
                colorFilter: ColorFilter.mode(
                  textColor ?? Colors.white // AppTheme.primaryButtonText!
                  ,
                  BlendMode.srcIn,
                )),
          ),
          Text(
            text,
            style: TextStyle(
                color:
                    textColor ?? Colors.white, // AppTheme.primaryButtonText!,
                fontSize: defaultFontSize),
            textAlign: TextAlign.center,
          ),
        ]),
        decoration: BoxDecoration(
            // shape: BoxShape.circle,
            borderRadius:
                BorderRadius.all(Radius.circular(ThemeSize.themeBorderRadius)),
            color: backgroundColor ?? Colors.black
            // AppTheme
            //     .primaryButtonBackground // ?? AppColors.accent, // Color(0xFFF2F3F7)
            ),
      ),
    );
  }
}
