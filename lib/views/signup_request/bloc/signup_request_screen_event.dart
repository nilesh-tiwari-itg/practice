class SignupRequestScreenEvent {}

class SignupRequestScreenPageChangeEvent extends SignupRequestScreenEvent {
  final int currentPage;
  SignupRequestScreenPageChangeEvent(this.currentPage);
}

class SignupRequestScreenSearchEvent extends SignupRequestScreenEvent {
  final String searchQuery;
  SignupRequestScreenSearchEvent(this.searchQuery);
}