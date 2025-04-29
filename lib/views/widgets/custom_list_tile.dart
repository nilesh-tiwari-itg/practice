import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListTile extends StatelessWidget {
  final double defaultFontSize = 18;
  final String text;
  final Function()? onPressed;
  // final Color? backgroundColor;
  final String? leadingIcon;
  final String? trailingIcon;
  final ShapeBorder? borderShape;

  CustomListTile(
      {super.key,
      required this.text,
      this.onPressed,
      this.leadingIcon,
      this.trailingIcon,
      this.borderShape});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: borderShape,
      // leading: Icon(
      //   leadingIcon,
      //   // color: Colors.black,
      // ),
      leading: Container(
        width: 25,
        //MediaQuery.of(context).size.width * 0.058,
        child: SvgPicture.asset(leadingIcon!,
            colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color!, BlendMode.srcIn)),
      ),
      title: Text(
        text,
        // style:
        // CustomTextTheme.getTextStyle(MyTextStyle.ListTileTitle, context),
        style: TextStyle(color: Colors.black),
      ),
      trailing: Container(
        width: 25, //MediaQuery.of(context).size.width * 0.058,
        child: SvgPicture.asset(trailingIcon!,
            colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color!, BlendMode.srcIn)),
      ),
      onTap: onPressed,
    );
  }
}
