// lib/metrics/presentation/screens/patient_list_screen.dart
import 'package:flutter/material.dart';

class PatientListScreen extends StatefulWidget {
  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final List<Map<String, dynamic>> _patients = [];

  void _addNewPatient(Map<String, dynamic> patient) {
    setState(() {
      _patients.add(patient);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_patient').then((result) {
            if (result is Map<String, dynamic>) {
              _addNewPatient(result); // Asegurarse de que sea del tipo correcto
            }
          });
        },
        child: Icon(Icons.add),
        tooltip: 'Add new patient',
      ),
      body: ListView.builder(
        itemCount: _patients.length,
        itemBuilder: (context, index) {
          final patient = _patients[index];
          return ListTile(
            title: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/patient_details', arguments: patient),
              child: Text('${patient['name']} ${patient['lastName']}', style: TextStyle(fontSize: 18)),
            ),
          );
        },
      ),
    );
  }
}
