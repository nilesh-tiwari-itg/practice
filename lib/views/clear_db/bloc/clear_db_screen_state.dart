class ClearDbScreenState {}

class ClearDbScreenInitialState extends ClearDbScreenState {}

class ClearDbScreenSubmittingState extends ClearDbScreenState {}

class ClearDbScreenLoadingState extends ClearDbScreenState {}

class ClearDbScreenSuccessState extends ClearDbScreenState {}

class ClearDbScreenFailureState extends ClearDbScreenState {
  String message;
  ClearDbScreenFailureState(this.message);
}
