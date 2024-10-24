// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miam_flutter/account/application/bloc_or_cubit/login_cubit.dart';
import 'package:miam_flutter/account/infrastructure/repositories_implementations/auth_repository_impl.dart';
import 'package:miam_flutter/account/presentation/screens/login_screen.dart';
import 'package:miam_flutter/account/application/use_cases/login_use_case.dart';

import 'package:miam_flutter/metrics/presentation/screens/monitoring_screen.dart';
import 'package:miam_flutter/metrics/application/bloc_or_cubit/vital_sign_cubit.dart';
import 'package:miam_flutter/metrics/infrastructure/repositories_implementations/vital_sign_repository_impl.dart';
import 'package:miam_flutter/metrics/application/use_cases/get_vital_signs_use_case.dart';


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
        ),/*
        BlocProvider<VitalSignCubit>(
          create: (context) => VitalSignCubit(
            GetVitalSignsUseCase(VitalSignRepositoryImpl()),
          )..startMonitoring(), // Iniciar el monitoreo de signos vitales
        ),*/
      ],
      child: MaterialApp(
        title: 'Flutter DDD Login',
        //home: MonitoringScreen(),
        home: LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
