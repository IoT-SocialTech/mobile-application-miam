// lib/metrics/presentation/screens/patient_details_screen.dart
import 'package:flutter/material.dart';

class PatientDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> patientData;

  const PatientDetailsScreen({Key? key, required this.patientData}) : super(key: key);

  @override
  _PatientDetailsScreenState createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  final List<Map<String, String>> _medicationAlerts = [];

  void _addMedicationAlert(String medication, String dosage, String schedule) {
    setState(() {
      _medicationAlerts.add({
        'medication': medication,
        'dosage': dosage,
        'schedule': schedule,
      });
    });
  }

  void _showAddAlertDialog() {
    final TextEditingController _medicationController = TextEditingController();
    final TextEditingController _dosageController = TextEditingController();
    final TextEditingController _scheduleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Medication Alert'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _medicationController,
                  decoration: InputDecoration(labelText: 'Medication'),
                ),
                TextField(
                  controller: _dosageController,
                  decoration: InputDecoration(labelText: 'Dosage'),
                ),
                TextField(
                  controller: _scheduleController,
                  decoration: InputDecoration(labelText: 'Schedule'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_medicationController.text.isNotEmpty &&
                    _dosageController.text.isNotEmpty &&
                    _scheduleController.text.isNotEmpty) {
                  _addMedicationAlert(
                    _medicationController.text,
                    _dosageController.text,
                    _scheduleController.text,
                  );
                  Navigator.of(context).pop(); // Cerrar el diálogo
                }
              },
              child: Text('Add Alert'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeletePatient() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Patient'),
          content: Text('Are you sure you want to delete this patient?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
                Navigator.popUntil(context, (route) => route.isFirst); // Volver a la lista de pacientes
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mostrar la información del paciente
            Text(
              'Patient Name: ${widget.patientData['name']} ${widget.patientData['lastName']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Birth Date: ${widget.patientData['birthDate']}'),
            Text('Age: ${widget.patientData['age']}'),
            Text('Caregiver: ${widget.patientData['caregiver']}'),
            Text('Relative: ${widget.patientData['relative']}'),
            SizedBox(height: 20),

            // Sección de alertas de medicación
            Text(
              'Medication Alerts',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ..._medicationAlerts.map((alert) {
              return ListTile(
                title: Text('Medication: ${alert['medication']}'),
                subtitle: Text('Dosage: ${alert['dosage']} - Schedule: ${alert['schedule']}'),
              );
            }).toList(),
            ElevatedButton(
              onPressed: _showAddAlertDialog, // Muestra el diálogo para agregar alerta
              child: Text('Add Alert'),
            ),
            SizedBox(height: 20),

            // Título y datos de salud
            Text(
              'Health Data',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Last Temperature Reading: ${widget.patientData['lastTemperatureReading']}'),
            Text('Last Heart Rate Reading: ${widget.patientData['lastHeartRateReading']}'),
            SizedBox(height: 20),

            // Botones de acción
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst); // Volver a la lista de pacientes
                  },
                  child: Text('Back to Patients'),
                ),
                ElevatedButton(
                  onPressed: _confirmDeletePatient,
                  child: Text('Delete Patient'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
