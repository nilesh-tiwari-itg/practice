import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_backend/views/signup_request/bloc/signup_request_screen_bloc.dart';
import 'package:practice_backend/views/signup_request/bloc/signup_request_screen_state.dart';

class SignupRequestScreen extends StatelessWidget {
  const SignupRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SignupRequestScreenBloc(),
        child: BlocListener<SignupRequestScreenBloc, SignupRequestScreenState>(
          listener: (context, state) {},
          child: BlocBuilder<SignupRequestScreenBloc, SignupRequestScreenState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Signup Request'),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text('Request a signup link'),
                        ListTile(
                          leading: Icon(Icons.person_add),
                          title: Text('Request 1'),
                          subtitle: Text('Details about request 1'),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            // Handle request tap
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
