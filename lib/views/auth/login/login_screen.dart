import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_backend/views/auth/login/bloc/login_screen_bloc.dart';
import 'package:practice_backend/views/auth/signup/sign_up_screen.dart';
import 'package:practice_backend/views/home_screen/home_screen.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/gap_widget.dart';
import '../../widgets/link_button.dart';
import '../../widgets/link_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    return BlocProvider(
      create: (context) => LoginScreenBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              // color: AppTheme.backgroundColor!, //.white70,
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      child: Container(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(Icons.close),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: 130,
                            height: 130,
                            alignment: Alignment.center,
                            child: Text("Login")
                            // Image.asset("assets/images/ic_app_icon.png"),
                            ),
                        GapWidget(),
                        CustomTextFormField().SimpleTextFormFieldWithPrefixIcon(
                          hintText: "Email",
                          prefixIcon: "assets/images/Email.svg",
                          context: context,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        GapWidget(),
                        SimpleTextFormFieldWithPrefixIconAndVisibilityToggle(
                          context: context,
                          controller: passwordController,
                          hintText: "Password",
                          prefixIcon: "assets/images/lock_pass.svg",
                          obscureText: true,
                        ),
                        GapWidget(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            LinkButton(
                              text: "Forgot your password?",
                              onPressed: () {},
                            )
                          ],
                        ),
                        GapWidget(),
                        CustomButton(
                          text: 'Sign In',
                          onPressed: () {
                            if (emailController.text.isEmpty) {
                              Dialogs.ErrorAlertInOut(
                                  context: context, message: 'emailRequired');
                            } else if (passwordController.text.isEmpty) {
                              Dialogs.ErrorAlertInOut(
                                  context: context,
                                  message: 'passwordRequired');
                            } else if (!Validations.emailValidation(
                                emailController.text)) {
                              Dialogs.ErrorAlertInOut(
                                  context: context, message: 'emailInvalid');
                            } else if (passwordController.text.trim().length <
                                    5 ||
                                passwordController.text.contains(" ")) {
                              Dialogs.ErrorAlertInOut(
                                  context: context,
                                  message: 'passwordCharacter');
                            } else {
                              context.read<LoginBloc>().add(OnLoginButtonClick(
                                  emailController.text.trim(),
                                  passwordController.text.trim()));
                            }
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => HomeScreen()));
                          },
                        ),
                        GapWidget(
                          size: -5,
                        )
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
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Color(0xFF666666),
                                fontFamily: defaultFontFamily,
                                fontSize: defaultFontSize,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          LinkButton(
                              text: "Sign Up",
                              onPressed: () {
                                // if (goBack) {
                                //   SignUpScreen signUpScreen =
                                //       SignUpScreen(goBack);
                                //   bool? refresh = await context.push(
                                //       "/${Routes.signUpScreen}",
                                //       extra: signUpScreen);
                                //   if (refresh != null) {
                                //     if (refresh as bool) {
                                //       // context.pop(true);
                                //       Navigator.pop(context);
                                //     }
                                //   }
                                // } else {
                                //extra goback
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                                // }
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
      }),
    );
  }
}
