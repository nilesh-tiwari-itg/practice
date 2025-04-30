import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_backend/models/user_model.dart';
import 'package:practice_backend/repository/api_const.dart';
import 'package:practice_backend/repository/api_repository.dart';
import 'package:practice_backend/repository/api_response.dart';
import 'package:practice_backend/session/session.dart';
import 'package:practice_backend/views/auth/login/bloc/login_screen_event.dart';
import 'package:practice_backend/views/auth/login/bloc/login_screen_state.dart';
import 'package:practice_backend/globals.dart' as globals;

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc() : super(LoginScreenInitialState()) {
    on<onLoginScreenButtonClick>((event, emit) async {
      loginApi(event);
    });
  }

  bool isBlocClosed = false;
  @override
  Future<void> close() {
    isBlocClosed = true;
    return super.close();
  }

  loginApi(onLoginScreenButtonClick eventData) async {
    if (!isBlocClosed) {
      emit(LoginScreenSubmittingState());
    }

    try {
      var formData = {"email": eventData.email, "password": eventData.password};
      ApiResponse apiResponse =
          await ApiRepository.postAPI(ApiConst.login, formData);

      debugPrint("-----login Bloc-------${apiResponse.toJson()}");
      if (apiResponse.status) {
        UserModel user = UserModel.fromJson(apiResponse.data["user"]);
        String accessToken = apiResponse.data["token"];

        globals.isLogin = true;
        Session().setIsLogin(true);
        Session().setUser(user);
        Session().setToken(accessToken);

        debugPrint("-----login Bloc Success-------");

        if (!isBlocClosed) {
          emit(LoginScreenSuccessState());
        }
      } else {
        debugPrint("-----login Bloc Failure------${apiResponse.message}-");
        if (!isBlocClosed) {
          emit(LoginScreenFailureState(apiResponse.message));
        }
      }
    } catch (e) {
      debugPrint("-----login Bloc Error------${e.toString()}-");
      if (!isBlocClosed) {
        emit(LoginScreenFailureState("Something went wrong"));
      }
    } finally {
      if (!isBlocClosed) {
        emit(LoginScreenInitialState());
      }
    }
  }
}
