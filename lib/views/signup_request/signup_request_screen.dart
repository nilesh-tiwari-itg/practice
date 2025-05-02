import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_backend/views/signup_request/bloc/signup_request_screen_bloc.dart';
import 'package:practice_backend/views/signup_request/bloc/signup_request_screen_state.dart';
import 'package:practice_backend/views/widgets/custom_list_tile.dart';
import 'package:practice_backend/views/widgets/custom_pagination_widget.dart';

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
                body: state is SignupRequestScreenLoadingState
                    ? Center(child: CircularProgressIndicator())
                    : state is SignupRequestScreenSuccessState
                        ? Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.signupRequestsModel
                                          .pendingRequests?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: Icon(Icons.person_add),
                                      title: Text(state
                                              .signupRequestsModel
                                              .pendingRequests![index]
                                              .fullName ??
                                          ''),
                                      subtitle: Text(state.signupRequestsModel
                                              .pendingRequests![index].email ??
                                          ''),
                                      trailing: Icon(Icons.arrow_forward),
                                      onTap: () {},
                                    );
                                  },
                                ),
                              ),
                              CustomPaginationWidget(
                                totalPages:
                                    state.signupRequestsModel.totalPages ?? 0,
                                currentPage:
                                    state.signupRequestsModel.currentPage ?? 0,
                                onPageChange: (page) {
                                  // Handle page change
                                },
                              ),
                            ],
                          )
                        : Container(
                            child: Center(
                              child: Text('No requests found'),
                            ),
                          ),
              );
            },
          ),
        ));
  }
}
