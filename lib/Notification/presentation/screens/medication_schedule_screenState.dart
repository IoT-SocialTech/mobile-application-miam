import 'package:flutter/material.dart';
import 'package:miam_flutter/Notification/domain/repositories/medication_patient_repository.dart';
import 'package:miam_flutter/Notification/domain/entities/responseMedication.dart';
import 'package:miam_flutter/Device/domain/repositories/patient_caregiver_repository.dart';
import 'package:miam_flutter/Device/domain/entities/responsePatient.dart';
import 'package:miam_flutter/account/application/bloc_or_cubit/login_cubit.dart';

import '../../../account/domain/repositories/caregiver_repository.dart';

class MedicationScheduleScreen extends StatefulWidget {
  @override
  _MedicationScheduleScreenState createState() => _MedicationScheduleScreenState();
}

class _MedicationScheduleScreenState extends State<MedicationScheduleScreen> {
  List<ResponseMedication> medications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMedications();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchMedications(); // Actualizar los datos cada vez que se entra al screen
  }

  Future<void> _fetchMedications() async {
    try {
      final medicationRepository = MedicationPatientRepository();
      final caregiverRepository = CaregiverRepository();

      // Obtener el caregiver ID del usuario logueado
      final accountId = await getUserId() ?? 0;
      final caregiver = await caregiverRepository.getCaregiverByAccountId(accountId);
      int caregiverId = caregiver.id ?? 17;

      print("Caregiver ID: $caregiverId");
      final fetchedMedications = await medicationRepository.getMedicationsByCaregiverId(caregiverId);

      setState(() {
        medications = fetchedMedications;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching medications: ${e.toString()}")),
      );
    }
  }

  Future<void> _deleteMedication(int medicationId) async {
    try {
      final medicationRepository = MedicationPatientRepository();
      await medicationRepository.deleteMedicationbyId(medicationId);

      setState(() {
        medications.removeWhere((medication) => medication.id == medicationId);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Medication deleted successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting medication: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medication Schedule"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : medications.isEmpty
          ? Center(child: Text("No medications found."))
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: medications.length,
          itemBuilder: (context, index) {
            final medication = medications[index];
            return _buildMedicationCard(context, medication);
          },
        ),
      ),
    );
  }

  Widget _buildMedicationCard(BuildContext context, ResponseMedication medication) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date: ${medication.hour.split('T')[0]}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Hour: ${medication.hour}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text("Medication: ${medication.medicationName}"),
            SizedBox(height: 8),
            Text("Dose: ${medication.dose}"),
            SizedBox(height: 8),
            Text("Taken: ${medication.taken ? 'Yes' : 'No'}"),
            SizedBox(height: 8),
            FutureBuilder<ResponsePatient>(
              future: PatientCaregiverRepository().getPatientById(medication.patientId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading patient...");
                }
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                final patient = snapshot.data;
                if (patient != null) {
                  return Text("Patient: ${patient.name} ${patient.lastName}");
                } else {
                  return Text("Patient not found");
                }
              },
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _showMedicationDetails(context, medication);
                  },
                  icon: Icon(Icons.info),
                  label: Text("More Info"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _showDeleteConfirmation(context, medication.id);
                  },
                  icon: Icon(Icons.delete, color: Colors.white),
                  label: Text("Delete"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMedicationDetails(BuildContext context, ResponseMedication medication) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Medication Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Medication Name: ${medication.medicationName}"),
            Text("Dose: ${medication.dose}"),
            Text("Hour: ${medication.hour}"),
            Text("Taken: ${medication.taken ? 'Yes' : 'No'}"),
            Text("Patient ID: ${medication.patientId}"),
            Text("Caregiver ID: ${medication.caregiverId}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int medicationId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Medication'),
        content: Text('Are you sure you want to delete this medication?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteMedication(medicationId);
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
