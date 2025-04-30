import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_backend/repository/api_const.dart';
import 'package:practice_backend/repository/api_repository.dart';
import 'package:practice_backend/repository/api_response.dart';
import 'package:practice_backend/views/signup_request/bloc/signup_request_screen_event.dart';
import 'package:practice_backend/views/signup_request/bloc/signup_request_screen_state.dart';

class SignupRequestScreenBloc
    extends Bloc<SignupRequestScreenEvent, SignupRequestScreenState> {
  SignupRequestScreenBloc() : super(SignupRequestScreenInitialState()) {}

  bool isBlocClosed = false;
  @override
  Future<void> close() {
    isBlocClosed = true;
    return super.close();
  }

  loadSignUpRequests() async {
    if (!isBlocClosed) {
      emit(SignupRequestScreenLoadingState());
    }

    try {
      ApiResponse apiResponse =
          await ApiRepository.getApi(ApiConst.signupRequest);

      debugPrint("-----loadSignUpRequest Bloc-------${apiResponse.toJson()}");

      if (apiResponse.status) {
        debugPrint("-----loadSignUpRequest Bloc Success-------");

        if (!isBlocClosed) {
          emit(SignupRequestScreenSuccessState());
        }
      } else {
        debugPrint(
            "-----loadSignUpRequest Bloc Failure------${apiResponse.message}-");
        if (!isBlocClosed) {
          emit(SignupRequestScreenFailureState(apiResponse.message));
        }
      }
    } catch (e) {
      debugPrint("-----loadSignUpRequest Bloc Error------${e.toString()}-");
      if (!isBlocClosed) {
        emit(SignupRequestScreenFailureState("Something went wrong"));
      }
    } finally {
      if (!isBlocClosed) {
        emit(SignupRequestScreenInitialState());
      }
    }
  }
}
