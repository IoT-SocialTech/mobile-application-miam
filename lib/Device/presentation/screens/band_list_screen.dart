import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miam_flutter/account/application/bloc_or_cubit/login_cubit.dart';

class BandListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> bands = [
    {'id': 1, 'patientName': 'Carlos'},
    {'id': 2, 'patientName': 'María'},
    {'id': 3, 'patientName': 'Juan'},
    {'id': 4, 'patientName': 'Ana'},
    {'id': 5, 'patientName': 'Luis'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Band Configuration"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddPatientForm(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, index) {
            final band = bands[index];
            return _buildBandCard(context, band);
          },
        ),
      ),
    );
  }

  Widget _buildBandCard(BuildContext context, Map<String, dynamic> band) {
    return GestureDetector(
      onTap: () {
        // Navegar a la pantalla de configuración de bandas
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.blue[50],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ID: ${band['id']}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "Patient: ${band['patientName']}",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddPatientForm(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController birthdateController = TextEditingController();
    final TextEditingController relativeIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Patient"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(labelText: "Last Name"),
                ),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(labelText: "Age"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: "Address"),
                ),
                TextField(
                  controller: birthdateController,
                  decoration: InputDecoration(labelText: "Birthdate (YYYY-MM-DD)"),
                ),
                TextField(
                  controller: relativeIdController,
                  decoration: InputDecoration(labelText: "Relative ID"),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final currentContext = context; // Guarda el contexto actual

                try {

                  await currentContext.read<LoginCubit>().createPatient(
                    name: nameController.text,
                    lastName: lastNameController.text,
                    age: int.parse(ageController.text),
                    address: addressController.text,
                    birthdate: birthdateController.text,
                    relativeId: int.parse(relativeIdController.text),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Patient Created Successfully!")),
                  );
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: ${e.toString()}")),
                  );
                }
              },
              child: Text("Add Patient"),
            ),
          ],
        );
      },
    );
  }
}
