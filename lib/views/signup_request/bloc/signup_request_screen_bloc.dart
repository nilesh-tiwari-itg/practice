import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_backend/models/signup_requests_model.dart';
import 'package:practice_backend/repository/api_const.dart';
import 'package:practice_backend/repository/api_repository.dart';
import 'package:practice_backend/repository/api_response.dart';
import 'package:practice_backend/session/session.dart';
import 'package:practice_backend/views/signup_request/bloc/signup_request_screen_event.dart';
import 'package:practice_backend/views/signup_request/bloc/signup_request_screen_state.dart';

class SignupRequestScreenBloc
    extends Bloc<SignupRequestScreenEvent, SignupRequestScreenState> {
  SignupRequestScreenBloc() : super(SignupRequestScreenInitialState()) {
    loadSignUpRequests();

    on<SignupRequestScreenEvent>((event, emit) {
      // if (event is SignupRequestScreenLoadEvent) {
      //   currentPage = event.currentPage;
      //   limit = event.limit;
      //   searchQuery = event.searchQuery;
      //   loadSignUpRequests();
      // } else
      if (event is SignupRequestScreenSearchEvent) {
        searchQuery = event.searchQuery;
        currentPage = 1;
        loadSignUpRequests();
      } else if (event is SignupRequestScreenPageChangeEvent) {
        currentPage = event.currentPage;
        loadSignUpRequests();
      }
    });
  }

  bool isBlocClosed = false;
  @override
  Future<void> close() {
    isBlocClosed = true;
    return super.close();
  }

  int totalPages = 1;
  int currentPage = 1;
  int limit = 5;
  String searchQuery = "";

  loadSignUpRequests() async {
    if (!isBlocClosed) {
      emit(SignupRequestScreenLoadingState());
    }

    var token = await Session().getToken();
    var formData = {"query": searchQuery, "page": currentPage, "limit": limit};

    try {
      ApiResponse apiResponse = await ApiRepository.postAPI(
          ApiConst.signupRequest, formData,
          token: "Bearer $token");

      // debugPrint("-----loadSignUpRequest Bloc-------${apiResponse.toJson()}");

      if (apiResponse.status) {
        SignupRequestsModel signupRequestsModel =
            SignupRequestsModel.fromJson(apiResponse.data);

        debugPrint(
            "-loadSignUpRequest Bloc Success--signupRequestsModel ${signupRequestsModel.toJson()}");

        if (!isBlocClosed) {
          emit(SignupRequestScreenSuccessState(signupRequestsModel));
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
      // } finally {
      //   if (!isBlocClosed) {
      //     emit(SignupRequestScreenInitialState());
      //   }
    }
  }
}
