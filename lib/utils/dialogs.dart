import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practice_backend/utils/theme_size.dart';

enum DIALOG_ACTION { YES, ABORT, PERMANENT_CLOSE }

class Dialogs {
  static void successDialog({required String message}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.lightGreen,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static errorDialog({required String message}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Future<DIALOG_ACTION> customAbortDialog(
      BuildContext context, String title, String body,
      {String? primarybuttonText, String? secondarybuttonText}) async {
    primarybuttonText = primarybuttonText ?? "No";
    secondarybuttonText = secondarybuttonText ?? "Yes";

    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            elevation: 2,
            contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
            titlePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            buttonPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            actionsPadding: EdgeInsets.fromLTRB(5, 0, 5, 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ThemeSize.themeBorderRadius),
            ),
            // title: Text(
            //   title,
            //   style: Theme.of(context)
            //       .textTheme
            //       .bodyLarge!,
            // ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  title != ""
                      ? Container(
                          alignment: Alignment.center,
                          child: Text(
                            title,
                            style:
                                // CustomTextTheme.getTextStyle(
                                //     MyTextStyle.DialogsTitleFontSize, context)
                                Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontSize: ThemeSize.dialogTitleFontSize,
                                        fontWeight: FontWeight.bold),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: title != "" ? 8 : 1,
                  ),
                  body != ""
                      ? Container(
                          margin: EdgeInsets.only(bottom: body != "" ? 10 : 1),
                          alignment: Alignment.center,
                          child: Text(
                            body,
                            style:
                                // CustomTextTheme.getTextStyle(
                                //     MyTextStyle.DialogsDescriptionsFontSize,
                                //     context)
                                Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontSize:
                                            ThemeSize.dialogDescriptionFontSize,
                                        fontWeight: FontWeight.bold),
                          ))
                      : Container(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () =>
                                // context.pop(DIALOG_ACTION.YES),
                                Navigator.of(context).pop(DIALOG_ACTION.YES),
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
                              padding: EdgeInsets.fromLTRB(22, 5, 22, 5),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors
                                          .black, //AppTheme.secondaryButtonBackground!,
                                      Colors
                                          .black54, //AppTheme.secondaryButtonBackground!,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      ThemeSize.themeBorderRadius)),
                              child: Text(
                                secondarybuttonText!,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontSize:
                                            ThemeSize.dialogSubTitleFontSize,
                                        fontWeight: FontWeight.bold),
                                // style: CustomTextTheme.getTextStyle(
                                //         MyTextStyle.DialogsSubTitleFontSize,
                                //         context)
                                //     .copyWith(
                                //         color:
                                //             AppTheme.secondaryButtonText!)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () =>
                                // context.pop(DIALOG_ACTION.ABORT),
                                Navigator.of(context).pop(DIALOG_ACTION.ABORT),
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
                              padding: EdgeInsets.fromLTRB(22, 5, 22, 5),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors
                                          .black, //AppTheme.primaryButtonBackground!,

                                      Colors
                                          .black, //AppTheme.primaryButtonBackground!,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      ThemeSize.themeBorderRadius)),
                              child: Text(
                                primarybuttonText!,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontSize:
                                            ThemeSize.dialogSubTitleFontSize,
                                        fontWeight: FontWeight.bold),
                                // style: CustomTextTheme.getTextStyle(
                                //         MyTextStyle.DialogsSubTitleFontSize,
                                //         context)
                                //     .copyWith(
                                //         color: AppTheme.primaryButtonText!)
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
    return (action != null) ? action : DIALOG_ACTION.ABORT;
  }
}
