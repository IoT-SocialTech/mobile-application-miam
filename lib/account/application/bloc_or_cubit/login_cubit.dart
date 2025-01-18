// lib/account/application/bloc_or_cubit/login_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miam_flutter/account/application/use_cases/login_use_case.dart';
import 'package:miam_flutter/account/application/use_cases/create_account_use_case.dart';
import 'package:miam_flutter/account/domain/entities/account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:miam_flutter/account/domain/entities/auth_response.dart';
import 'package:miam_flutter/account/domain/repositories/auth_repository.dart';
import 'package:miam_flutter/account/domain/repositories/caregiver_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final CreateAccountUseCase createAccountUseCase;

  AuthResponse? _authResponse; // Para almacenar el token y el ID
  AuthResponse? get authResponse => _authResponse; // Getter para acceder al token y al ID
  Account? _currentAccount; // Almacena temporalmente el usuario
  Account? get currentAccount => _currentAccount; // Getter para acceder al usuario

  // Modificar el constructor para incluir el repositorio
  LoginCubit(
      this.loginUseCase,
      this.createAccountUseCase
      ) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final response = await loginUseCase.execute(email, password);
      _authResponse = response; // Guardar el token y el ID en la variable local

      // Guardar el token de manera persistente
      await saveToken(response.token);
      await saveUserId(response.id); // Guardar el ID en SharedPreferences
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> createAccount({
    required String email,
    required String password,
    required int phoneNumber,
    required int subscription,
    required int role,
    required bool active,
  }) async {
    emit(LoginLoading());
    try {
      final account = await createAccountUseCase(
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        subscription: subscription,
        role: role,
        active: active,
      );
      _currentAccount = account;
      await saveUserId(account.id);

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> registerCaregiver({
    required String email,
    required String password,
    required int phoneNumber,
    required int subscription,
    required String name,
    required String lastName,
    required String address,
    required List<int> patientIds,
    required List<int> nursingHomeIds,
  }) async {
    emit(LoginLoading());

    try {
      // Paso 1: Crear la cuenta
      final account = await createAccountUseCase(
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        subscription: subscription,
        role: 2,
        active: true,
      );
      //saveToken("eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzdHJpbmdAZ21haWwuY29tIiwiaWF0IjoxNzMxOTExNjU4LCJleHAiOjE3MzQ1MDM2NTgsInJvbGVzIjpbXX0.9PKY0DIhD-whHGYcCj8CwAHusCCPoRVYvZpwclDMJJA");
      //print("se creo el account");
      //Paso 2: Iniciar sesión
      final authResponse = await loginUseCase.execute(email, password);
      // Guardar el token de manera persistente
      await saveToken(authResponse.token);
      await saveUserId(authResponse.id); // Guardar el ID en SharedPreferences

      print("inicio sesion token: ${authResponse.token} ");
      print("inicio sesion id: ${authResponse.id} ");
      // Paso 3: Crear el caregiver
      await createAccountUseCase.createCaregiver(
        name: name,
        lastName: lastName,
        address: address,
        account: account.id,
        patientIds: patientIds,
        nursingHomeIds: nursingHomeIds,
      );
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> createPatient({
    required String name,
    required String lastName,
    required int age,
    required String address,
    required String birthdate,
    //required int accountId,
    required int relativeId,
    //required List<int> caregiverIds,
  }) async {
    try {
      // crear el repositorio de caregiver
      final caregiverRepository = CaregiverRepository();

      // obtener el el response caregiver por el id del account
      //final caregiver = await caregiverRepository.getCaregiverByAccountId(_currentAccount!.id);
      int id = await getUserId()?? 0;
      print("account id: $id");
      final caregiver = await caregiverRepository.getCaregiverByAccountId(id);
      print("Caregiver: ${caregiver.id}");


      final account = await createAccountUseCase(
        email: "${name}paciente$id$age@gmail.com",
        password: "Password$id",
        phoneNumber: 923456789,
        subscription: 1,
        role: 1,
        active: true,
      );

      print("paciente account: ${account.id??0}");
      print("email: ${name}paciente$id$age@gmail.com");
      print("relativeId: $relativeId");
      print("caregiverId: ${caregiver.id}");
      await createAccountUseCase.createPatient(
        name: name,
        lastName: lastName,
        age: age,
        address: address,
        birthdate: birthdate,
        accountId: account.id,
        relativeId: relativeId,
        caregiverIds: [caregiver.id],
      );

    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

}

Future<void> saveUserId(int id) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('userId', id);
}

Future<int?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('userId');
}

// Guardar el token
Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
}

// Recuperar el token
Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

// Borrar el token
Future<void> clearToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('auth_token');
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

