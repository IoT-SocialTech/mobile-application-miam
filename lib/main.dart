import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miam_flutter/account/application/bloc_or_cubit/login_cubit.dart';
import 'package:miam_flutter/account/application/use_cases/login_use_case.dart';
import 'package:miam_flutter/account/application/use_cases/create_account_use_case.dart';
import 'package:miam_flutter/account/infrastructure/repositories_implementations/auth_repository_impl.dart';
import 'package:miam_flutter/account/presentation/screens/login_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa OneSignal con tu App ID
  OneSignal.initialize("0c9a5867-f833-4ea5-8d68-3ec2cedc6fb7");
  OneSignal.Notifications.requestPermission(true);

  final authRepository = AuthRepositoryImpl();
  final loginUseCase = LoginUseCase(authRepository: authRepository);
  final createAccountUseCase = CreateAccountUseCase(authRepository: authRepository);

  runApp(
    BlocProvider(
      create: (context) => LoginCubit(loginUseCase, createAccountUseCase),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
