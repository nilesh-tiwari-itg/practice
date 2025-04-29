class LoginScreenState {}

class LoginScreenInitialState extends LoginScreenState {}

class LoginScreenSubmittingState extends LoginScreenState {}

class LoginScreenLoadingState extends LoginScreenState {}

class LoginScreenSuccessState extends LoginScreenState {}

class LoginScreenFailureState extends LoginScreenState {
  String message;
  LoginScreenFailureState(this.message);
}
