import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/theme_size.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextFormField {
  final double defaultFontSize = 14;
  final double defaultIconSize = 16;

  Widget SimpleTextFormField(
      {required BuildContext context,
      TextEditingController? controller,
      TextCapitalization? textCapitalization,
      required String? hintText,
      String? initialValue,
      TextInputType? keyboardType,
      Function(String)? onChanged,
      bool obscureText = false,int? maxLength}) {
    return Container(
      height: ThemeSize.themeTextFieldSize,
      alignment: Alignment.center,
      child: TextFormField(
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        // style: CustomTextTheme.getTextStyle(
        //     MyTextStyle.TextFormFieldInput, context),
        // style: AppTextTheme,
        maxLength: maxLength,
        controller: controller,
        obscureText: obscureText,
        initialValue: initialValue,
        onChanged: onChanged,
        cursorColor: Colors.black,// AppTheme.editTextControllerTextColor,
        keyboardType: keyboardType,
        showCursor: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(ThemeSize.themeBorderRadius)),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          // fillColor: Color(0xFFF2F3F5),
          // labelStyle: CustomTextTheme.getTextStyle(
          //     MyTextStyle.TextFormFieldInput, context),
          labelText: hintText,
counterText: ""        ),
      ),
    );
  }

  Widget SimpleTextFormFieldWithSuffixIcon(
      {required BuildContext context,
      TextEditingController? controller,
      required String? hintText,
      String? initialValue,
      Function(String)? onChanged,
      IconData? suffixIcon,
      bool obscureText = false,
      Function()? onClick,
      bool canRequestFocus = true}) {
    return Container(
      height: ThemeSize.themeTextFieldSize,
      alignment: Alignment.center,
      child: TextFormField(
        // style: CustomTextTheme.getTextStyle(
        //     MyTextStyle.TextFormFieldInput, context),
        controller: controller,
        obscureText: obscureText,
        initialValue: initialValue,
        onChanged: onChanged,
        canRequestFocus: canRequestFocus,
        onTap: () {
          onClick!.call();
        },
        cursorColor: Colors.black,//AppTheme.editTextControllerTextColor,
        // keyboardType: (hintText.contains(AppLocalizations.of(context)!.mobil))
        //     ? TextInputType.number
        //     : TextInputType.emailAddress,
        //   style: Theme.of(context)
        // .textTheme
        // .bodyMedium!
        // .copyWith(color: AppTheme.black,),
        showCursor: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(ThemeSize.themeBorderRadius)),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          suffixIcon: InkWell(
            onTap: () {
              onClick!.call();
            },
            child: Icon(
              suffixIcon,
              size: 20,
            ),
          ),

          // fillColor: Color(0xFFF2F3F5),
          // labelStyle: CustomTextTheme.getTextStyle(
          //     MyTextStyle.TextFormFieldInput, context),
          labelText: hintText,
        ),
      ),
    );
  }

  Widget SimpleTextFormFieldWithPrefixIcon(
      {required BuildContext context,
      TextInputType? keyboardType,
      TextCapitalization? textCapitalization,
      TextEditingController? controller,
      required String? hintText,
      String? initialValue,
      Function(String)? onChanged,
      String? prefixIcon,
      bool obscureText = false}) {
    return Container(
      height: ThemeSize.themeTextFieldSize,
      alignment: Alignment.center,
      child: TextFormField(
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        // style: CustomTextTheme.getTextStyle(
        //     MyTextStyle.TextFormFieldInput, context),
        controller: controller,
        obscureText: obscureText,
        initialValue: initialValue,
        onChanged: onChanged,
        cursorColor: Colors.black,//AppTheme.editTextControllerTextColor,
        keyboardType: keyboardType,
        showCursor: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(ThemeSize.themeBorderRadius)),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          prefixIcon: Container(
            padding: const EdgeInsets.all(14.0),
            width: MediaQuery.of(context).size.width * 0.02,
            child: SvgPicture.asset(
              prefixIcon!,
            ),
          ),
          // fillColor: Color(0xFFF2F3F5),
          // labelStyle: CustomTextTheme.getTextStyle(
          //     MyTextStyle.TextFormFieldInput, context),
          labelText: hintText,
        ),
      ),
    );
  }

  Widget SimpleTextFormFieldWithPrefixIconMessageField(
      {required BuildContext context,
      TextInputType? keyboardType,
      TextCapitalization? textCapitalization,
      TextEditingController? controller,
      required String? hintText,
      String? initialValue,
      Function(String)? onChanged,
      String? prefixIcon,
      bool obscureText = false}) {
    return Container(
      height: ThemeSize.themeTextFieldMessageSize,
      alignment: Alignment.topLeft,
      child: TextFormField(
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        // style: CustomTextTheme.getTextStyle(
        //     MyTextStyle.TextFormFieldInput, context),
        controller: controller,
        obscureText: obscureText,
        initialValue: initialValue,
        onChanged: onChanged,
        cursorColor: Colors.black,//AppTheme.editTextControllerTextColor,
        keyboardType: TextInputType.multiline,
        maxLines: 10,
        minLines: 3,
        showCursor: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(ThemeSize.themeBorderRadius)),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),

          filled: true,
          prefixIcon: Container(
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width * 0.02,
            child: SvgPicture.asset(
              alignment: Alignment.topLeft,
              prefixIcon!,
            ),
          ),
          // labelStyle: CustomTextTheme.getTextStyle(
          //     MyTextStyle.TextFormFieldInput, context),
          labelText: hintText,
        ),
      ),
    );
  }

  Widget SimpleTextFormFieldWithBothIcon(
      {required BuildContext context,
      TextEditingController? controller,
      TextInputType? keyboardType,
      required String? hintText,
      // String? Function(String?)? validator,
      String? initialValue,
      Function(String)? onChanged,
      // IconData? prefixIcon,
      IconData? suffixIcon,
      Color? suffixIconColor,
      bool obscureText = false,
      int? maxlength}) {
    return Container(
      height: ThemeSize.themeTextFieldSize,
      alignment: Alignment.center,
      child: TextFormField(
        // style: CustomTextTheme.getTextStyle(
        //     MyTextStyle.TextFormFieldInput, context),
        controller: controller,
        obscureText: obscureText,
        // validator: validator,
        initialValue: initialValue,
        maxLength: maxlength ,
        onChanged: onChanged,
        cursorColor: Colors.black,//AppTheme.editTextControllerTextColor,
        keyboardType: keyboardType,
        //   style: Theme.of(context)
        // .textTheme
        // .bodyMedium!
        // .copyWith(color: AppTheme.black,),
        showCursor: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(ThemeSize.themeBorderRadius)),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          // labelText: labelText,
          filled: true,
          // prefixIcon: Icon(
          //   prefixIcon,
          //   size: prefixIcon != null ? defaultIconSize : 0,
          // ),
          suffixIcon: Icon(
            suffixIcon,
            color: suffixIconColor,
            // color: Color(0xFF666666),
            size: defaultIconSize,
          ),
          // fillColor: Color(0xFFF2F3F5),
          // labelStyle: CustomTextTheme.getTextStyle(
          //     MyTextStyle.TextFormFieldInput, context),
          labelText: hintText,
        ),
      ),
    );
  }

  Widget SimpleTextFormFieldWithPrefixIconAndCountryCodeWithCursor(
      {required BuildContext context,
      TextEditingController? controller,
      TextInputType? keyboardType,
      required String? hintText,
      required String? phoneCode,
      // String? Function(String?)? validator,
      String? initialValue,
      Function(String)? onChanged,
      Function()? onClickCountry,
      String? prefixIcon,
      bool obscureText = false}) {
    return Container(
      height: ThemeSize.themeTextFieldSize,
      alignment: Alignment.center,
      child: TextFormField(
        // style: CustomTextTheme.getTextStyle(
        //     MyTextStyle.TextFormFieldInput, context),
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLength: 10,
        // validator: validator,
        initialValue: initialValue,
        onChanged: onChanged,
        cursorColor: Colors.black,// AppTheme.editTextControllerTextColor,

        // keyboardType: (hintText.contains(AppLocalizations.of(context)!.mobil))
        //     ? TextInputType.number
        //     : TextInputType.emailAddress,
        //   style: Theme.of(context)
        // .textTheme
        // .bodyMedium!
        // .copyWith(color: AppTheme.black,),
        showCursor: true,
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(ThemeSize.themeBorderRadius)),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          // labelText: labelText,
          filled: true,
          prefixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              prefixIcon == ""
                  ? Container()
                  : InkResponse(
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          // padding: EdgeInsets.all(10),
                          width: 25,
                          child: SvgPicture.asset(
                            prefixIcon!,
                          ),
                        ),
                      ),
                    ),
              InkResponse(
                onTap: () {
                  onClickCountry!.call();
                },
                child: Container(
                  alignment: Alignment.center,
                  // margin: const EdgeInsets.only(right: 5),
                  // width: 60,
                  padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                  child: Text(
                    phoneCode!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          // labelStyle: CustomTextTheme.getTextStyle(
          //     MyTextStyle.TextFormFieldInput, context),
          labelText: hintText,
        ),
      ),
    );
  }

  Widget SimpleTextFormFieldWithPrefixIconClickEvent(
      {required BuildContext context,
      TextEditingController? controller,
      required String? hintText,
      // String? Function(String?)? validator,
      String? initialValue,
      Function()? onClick,
      IconData? prefixIcon,
      bool obscureText = false}) {
    print("ccccccccccc....${initialValue}");
    return Container(
      height: ThemeSize.themeTextFieldSize,
      alignment: Alignment.center,
      child: TextFormField(
        // style: CustomTextTheme.getTextStyle(
        //     MyTextStyle.TextFormFieldInput, context),
        controller: controller,
        readOnly: true,
        // obscureText: obscureText,
        // validator: validator,
        // initialValue: initialValue!,
        onTap: () {
          print("sfsdf");
          //   FocusScope.of(context).requestFocus(new FocusNode());

          onClick!.call();
        },

        cursorColor: Colors.black,// AppTheme.editTextControllerTextColor,
        // keyboardType: (hintText.contains(AppLocalizations.of(context)!.mobil))
        //     ? TextInputType.number
        //     : TextInputType.emailAddress,
        //   style: Theme.of(context)
        // .textTheme
        // .bodyMedium!
        // .copyWith(color: AppTheme.black,),
        showCursor: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(ThemeSize.themeBorderRadius)),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          // labelText: labelText,
          filled: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Icon(
              prefixIcon,
              // color: Color(0xFF666666),
              size: prefixIcon != null ? defaultIconSize : 0,
            ),
          ),
          // labelStyle: CustomTextTheme.getTextStyle(
          //     MyTextStyle.TextFormFieldInput, context),
          labelText: hintText,
        ),
      ),
    );
  }
}

class SimpleTextFormFieldWithPrefixIconAndVisibilityToggle
    extends StatefulWidget {
  final BuildContext context;
  final TextEditingController? controller;
  final String? hintText;
  final String? prefixIcon;
  final bool obscureText;

  const SimpleTextFormFieldWithPrefixIconAndVisibilityToggle({
    required this.context,
    this.controller,
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
  });

  @override
  _SimpleTextFormFieldWithPrefixIconAndVisibilityToggleState createState() =>
      _SimpleTextFormFieldWithPrefixIconAndVisibilityToggleState();
}

class _SimpleTextFormFieldWithPrefixIconAndVisibilityToggleState
    extends State<SimpleTextFormFieldWithPrefixIconAndVisibilityToggle> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ThemeSize.themeTextFieldSize,
      alignment: Alignment.center,
      child: TextFormField(
        // style: CustomTextTheme.getTextStyle(
        //     MyTextStyle.TextFormFieldInput, widget.context),
        controller: widget.controller,
        obscureText: _isObscured,
        cursorColor: Colors.black,// AppTheme.editTextControllerTextColor,
        showCursor: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(ThemeSize.themeBorderRadius)),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          filled: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.06,
              child: SvgPicture.asset(
                widget.prefixIcon!,
              ),
            ),
          ),
          suffixIcon: InkWell(
            child: _isObscured
                ? Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.058,
                    child: SvgPicture.asset("assets/svg/eye_slash.svg"))
                : Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.058,
                    child: SvgPicture.asset("assets/svg/eye.svg")),
            onTap: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          ),
          // labelStyle: CustomTextTheme.getTextStyle(
          //     MyTextStyle.TextFormFieldInput, widget.context),
          labelText: widget.hintText,
        ),
      ),
    );
  }
}
