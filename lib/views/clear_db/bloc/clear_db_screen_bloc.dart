import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_backend/repository/api_const.dart';
import 'package:practice_backend/repository/api_repository.dart';
import 'package:practice_backend/repository/api_response.dart';
import 'package:practice_backend/views/clear_db/bloc/clear_db_screen_event.dart';
import 'package:practice_backend/views/clear_db/bloc/clear_db_screen_state.dart';

class ClearDbScreenBloc
    extends Bloc<ClearDbScreenEvent, ClearDbScreenState> {
  ClearDbScreenBloc() : super(ClearDbScreenInitialState()) {}

  bool isBlocClosed = false;
  @override
  Future<void> close() {
    isBlocClosed = true;
    return super.close();
  }

  clearDbChatHistory() async {
    if (!isBlocClosed) {
      emit(ClearDbScreenLoadingState());
    }

    try {
      ApiResponse apiResponse =
          await ApiRepository.getApi(ApiConst.signupRequest);

      debugPrint("-----clearDbChatHistory Bloc-------${apiResponse.toJson()}");

      if (apiResponse.status) {
        debugPrint("-----clearDbChatHistory Bloc Success-------");

        if (!isBlocClosed) {
          emit(ClearDbScreenSuccessState());
        }
      } else {
        debugPrint(
            "-----clearDbChatHistory Bloc Failure------${apiResponse.message}-");
        if (!isBlocClosed) {
          emit(ClearDbScreenFailureState(apiResponse.message));
        }
      }
    } catch (e) {
      debugPrint("-----clearDbChatHistory Bloc Error------${e.toString()}-");
      if (!isBlocClosed) {
        emit(ClearDbScreenFailureState("Something went wrong"));
      }
    } finally {
      if (!isBlocClosed) {
        emit(ClearDbScreenInitialState());
      }
    }
  }
}
