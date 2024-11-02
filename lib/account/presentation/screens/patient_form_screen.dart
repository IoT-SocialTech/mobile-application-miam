// lib/metrics/presentation/screens/patient_form_screen.dart
import 'package:flutter/material.dart';

class PatientFormScreen extends StatefulWidget {
  @override
  _PatientFormScreenState createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _caregiverController = TextEditingController();
  final TextEditingController _relativeController = TextEditingController();
  final TextEditingController _lastTemperatureReadingController = TextEditingController();
  final TextEditingController _lastHeartRateReadingController = TextEditingController();

  void _addPatient() {
    final Map<String, dynamic> newPatient = {
      'name': _nameController.text,
      'lastName': _lastNameController.text,
      'birthDate': _birthDateController.text,
      'age': _ageController.text,
      'caregiver': _caregiverController.text,
      'relative': _relativeController.text,
      'lastTemperatureReading': _lastTemperatureReadingController.text,
      'lastHeartRateReading': _lastHeartRateReadingController.text,
    };

    // Redirigir a la pantalla de detalles del paciente
    Navigator.pushNamed(context, '/patient_details', arguments: newPatient);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: _lastNameController, decoration: InputDecoration(labelText: 'Last Name')),
            TextField(controller: _birthDateController, decoration: InputDecoration(labelText: 'Birth Date')),
            TextField(controller: _ageController, decoration: InputDecoration(labelText: 'Age')),
            TextField(controller: _caregiverController, decoration: InputDecoration(labelText: 'Caregiver')),
            TextField(controller: _relativeController, decoration: InputDecoration(labelText: 'Relative')),
            TextField(controller: _lastTemperatureReadingController, decoration: InputDecoration(labelText: 'Last Temperature Reading')),
            TextField(controller: _lastHeartRateReadingController, decoration: InputDecoration(labelText: 'Last Heart Rate Reading')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPatient,
              child: Text('Add Patient'),
            ),
          ],
        ),
      ),
    );
  }
}
