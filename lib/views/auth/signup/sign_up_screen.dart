import 'package:flutter/material.dart';
import 'package:practice_backend/views/auth/login/login_screen.dart';
import 'package:practice_backend/views/home_screen/home_screen.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/gap_widget.dart';
import '../../widgets/link_button.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;

    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          // color: AppTheme.backgroundColor,
          child: Column(
            children: <Widget>[
              // Flexible(
              //   flex: 1,
              //   child: InkWell(
              //     child: Container(
              //       child: Align(
              //         alignment: Alignment.topLeft,
              //         child: Icon(Icons.close),
              //       ),
              //     ),
              //     onTap: (){
              //       Navigator.pop(context);
              //     },
              //   ),
              // ),
              Flexible(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 130,
                      height: 130,
                      alignment: Alignment.center,
                      child: Image.asset("assets/images/ic_app_icon.png"),
                    ),
                    GapWidget(),
                    Row(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: CustomTextFormField()
                              .SimpleTextFormField(context:context,hintText: "First Name"),
                        ),
                        GapWidget(
                          size: -5,
                        ),
                        Flexible(
                          flex: 1,
                          child: CustomTextFormField()
                              .SimpleTextFormField(context:context,hintText: "Last Name"),
                        ),
                      ],
                    ),
                    GapWidget(),
                    CustomTextFormField().SimpleTextFormFieldWithPrefixIcon(context:context,
                        hintText: "Email", prefixIcon: ""),
                    GapWidget(),
                    CustomTextFormField().SimpleTextFormFieldWithPrefixIcon(context:context,
                        hintText: "Password", prefixIcon: ""),
                    GapWidget(),
                    CustomButton(
                      text: 'Sign Up',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                      },
                    ),
                    GapWidget(
                      size: -5,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Already have an account? ",
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      LinkButton(
                          text: "Sign In",
                          onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
