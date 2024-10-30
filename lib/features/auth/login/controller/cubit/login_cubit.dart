import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code/core/app_string.dart';
import 'package:qr_code/core/cache_helper.dart';
import 'package:qr_code/core/dio_helper.dart';
import 'package:qr_code/core/end_points.dart';
import 'package:qr_code/features/auth/login/controller/login_model.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());
  late LoginModel loginModel;

  void login({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: Endpoints.login, data: {
      "email": email,
      "password": password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print('${loginModel.message}');
      if (loginModel.status == true) {
        CacheHelper.saveData(
            key: AppStrings.token, value: loginModel.data?.token ?? '');
        emit(LoginSuccessState());
      } else {
        emit(LoginFailedState(msg: loginModel.message ?? ''));
      }
    }).catchError((onError) {
      emit(LoginFailedState(msg: onError.toString()));
      print(onError);
    });
  }
}