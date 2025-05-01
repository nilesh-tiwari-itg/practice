import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_backend/views/clear_db/clear_db_screen.dart';
import 'package:practice_backend/views/signup_request/signup_request_screen.dart';
import 'package:practice_backend/views/widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  HomeScreenState();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.black, fontSize: 26),
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              text: "Signup Requests",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignupRequestScreen()));
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              text: "Clear DB Chat",
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ClearDbScreen()));
              },
            ),
          ],
        ),
      )),
    );
  }
}
