import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miam_flutter/account/application/bloc_or_cubit/login_cubit.dart';

class RegisterCaregiverScreen extends StatefulWidget {
  @override
  _RegisterCaregiverScreenState createState() => _RegisterCaregiverScreenState();
}

class _RegisterCaregiverScreenState extends State<RegisterCaregiverScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController patientIdsController = TextEditingController();
  final TextEditingController nursingHomeIdsController = TextEditingController();

  int selectedPlan = 1; // Default: Basic plan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Caregiver"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Campos de creación de cuenta
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 20),
              // Selección de plan
              Text("Select Subscription Plan"),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPlan = 1; // Basic plan
                        });
                      },
                      child: Card(
                        color: selectedPlan == 1 ? Colors.blue.shade100 : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text("Basic", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              SizedBox(height: 8),
                              Text("1 Caregiver account\nUp to 3 Family Member accounts\nUp to 3 health bands",
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPlan = 2; // Enterprise plan
                        });
                      },
                      child: Card(
                        color: selectedPlan == 2 ? Colors.blue.shade100 : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text("Enterprise", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              SizedBox(height: 8),
                              Text(
                                  "1 Administrator account\n1+ Caregiver accounts\n3+ Family Member accounts\nCustomized health bands",
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              // Campos para caregiver
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: "Last Name"),
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: "Address"),
              ),
              TextField(
                controller: patientIdsController,
                decoration: InputDecoration(labelText: "Patient IDs (comma-separated)"),
              ),
              TextField(
                controller: nursingHomeIdsController,
                decoration: InputDecoration(labelText: "Nursing Home IDs (comma-separated)"),
              ),

              SizedBox(height: 20),
              // Botón para completar el proceso
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  } else if (state is LoginSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Caregiver Registered Successfully!')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () async {
                      final patientIds = patientIdsController.text.isEmpty
                          ? <int>[] // Lista vacía de enteros si el campo está vacío
                          : patientIdsController.text
                          .split(',')
                          .map((e) => int.tryParse(e.trim()) ?? 0) // Asegúrate de convertir a int
                          .where((e) => e > 0) // Filtra valores no válidos (ej. 0 o negativos)
                          .toList();

                      final nursingHomeIds = nursingHomeIdsController.text.isEmpty
                          ? <int>[] // Lista vacía de enteros si el campo está vacío
                          : nursingHomeIdsController.text
                          .split(',')
                          .map((e) => int.tryParse(e.trim()) ?? 0) // Convierte a int
                          .where((e) => e > 0) // Filtra valores inválidos
                          .toList();

                      context.read<LoginCubit>().registerCaregiver(
                        email: emailController.text,
                        password: passwordController.text,
                        phoneNumber: int.tryParse(phoneNumberController.text) ?? 0,
                        subscription: selectedPlan,
                        name: nameController.text,
                        lastName: lastNameController.text,
                        address: addressController.text,
                        patientIds: patientIds,
                        nursingHomeIds: nursingHomeIds,
                      );
                    },
                    child: Text("Register Caregiver"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
