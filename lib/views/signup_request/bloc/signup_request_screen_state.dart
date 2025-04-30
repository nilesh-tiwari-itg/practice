class SignupRequestScreenState {}

class SignupRequestScreenInitialState extends SignupRequestScreenState {}

class SignupRequestScreenSubmittingState extends SignupRequestScreenState {}

class SignupRequestScreenLoadingState extends SignupRequestScreenState {}

class SignupRequestScreenSuccessState extends SignupRequestScreenState {}

class SignupRequestScreenFailureState extends SignupRequestScreenState {
  String message;
  SignupRequestScreenFailureState(this.message);
}
