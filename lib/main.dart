// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miam_flutter/account/application/bloc_or_cubit/login_cubit.dart';
import 'package:miam_flutter/account/infrastructure/repositories_implementations/auth_repository_impl.dart';
import 'package:miam_flutter/account/presentation/screens/login_screen.dart';
import 'package:miam_flutter/account/application/use_cases/login_use_case.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(
            LoginUseCase(AuthRepositoryImpl()),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter DDD Login',
        home: LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
