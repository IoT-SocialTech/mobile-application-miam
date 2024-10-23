// lib/account/application/bloc_or_cubit/login_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miam_flutter/account/application/use_cases/login_use_case.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoading());
      await loginUseCase.execute(email, password);
      emit(LoginSuccess());
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }
}

// login_state.dart
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}
