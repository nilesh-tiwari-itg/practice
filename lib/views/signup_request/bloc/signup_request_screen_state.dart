import 'package:practice_backend/models/signup_requests_model.dart';

class SignupRequestScreenState {}

class SignupRequestScreenInitialState extends SignupRequestScreenState {}

class SignupRequestScreenSubmittingState extends SignupRequestScreenState {}

class SignupRequestScreenLoadingState extends SignupRequestScreenState {}

class SignupRequestScreenSuccessState extends SignupRequestScreenState {
  SignupRequestsModel signupRequestsModel;
  SignupRequestScreenSuccessState(this.signupRequestsModel);
}

class SignupRequestScreenFailureState extends SignupRequestScreenState {
  String message;
  SignupRequestScreenFailureState(this.message);
}
