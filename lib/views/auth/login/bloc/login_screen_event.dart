class LoginScreenEvent {}

class onLoginScreenButtonClick extends LoginScreenEvent {
  String email;
  String password;
  onLoginScreenButtonClick(this.email, this.password);
}
