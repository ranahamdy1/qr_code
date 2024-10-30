part of 'login_cubit.dart';

abstract class LoginStates {}

class LoginInitial extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class LoginFailedState extends LoginStates {
  final String msg;
  LoginFailedState({required this.msg});
}