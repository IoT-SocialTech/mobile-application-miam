import 'package:flutter/material.dart';
import 'package:miam_flutter/Device/domain/repositories/patient_caregiver_repository.dart';
import 'package:miam_flutter/Device/domain/entities/responsePatient.dart';
import 'package:miam_flutter/Notification/domain/repositories/medication_patient_repository.dart';
import 'package:miam_flutter/account/domain/repositories/caregiver_repository.dart';
import 'package:miam_flutter/account/application/bloc_or_cubit/login_cubit.dart';


class BandConfigurationScreen extends StatefulWidget {
  final int patientId;

  BandConfigurationScreen({required this.patientId});

  @override
  _BandConfigurationScreenState createState() => _BandConfigurationScreenState();
}

class _BandConfigurationScreenState extends State<BandConfigurationScreen> {
  ResponsePatient? patient;
  int? caregiverId; // Variable para almacenar el caregiverId
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final patientCaregiverRepository = PatientCaregiverRepository();
      final caregiverRepository = CaregiverRepository();

      // Obtener el accountId
      int accountId = await getUserId() ?? 0;

      // Obtener el caregiverId
      final caregiver = await caregiverRepository.getCaregiverByAccountId(accountId);

      // Obtener los detalles del paciente
      final fetchedPatient = await patientCaregiverRepository.getPatientById(widget.patientId);

      setState(() {
        caregiverId = caregiver.id;
        patient = fetchedPatient;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching data: ${e.toString()}")),
      );
    }
  }

  Future<void> _addMedicationSchedule() async {
    if (caregiverId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Caregiver ID not found.")),
      );
      return;
    }

    final medicationRepository = MedicationPatientRepository();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController doseController = TextEditingController();
    final TextEditingController hourController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Medication"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Medication Name"),
                ),
                TextField(
                  controller: doseController,
                  decoration: InputDecoration(labelText: "Dose"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: hourController,
                  decoration: InputDecoration(labelText: "Hour (HH:mm:ss)"),
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
                try {
                  await medicationRepository.createMedicationSchedule(
                    medicationName: nameController.text,
                    dose: int.parse(doseController.text),
                    hour: hourController.text,
                    taken: false,
                    patientId: widget.patientId,
                    caregiverId: caregiverId!, // Usar el caregiverId dinámico
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Medication Added Successfully!")),
                  );
                  Navigator.of(context).pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: ${e.toString()}")),
                  );
                }
              },
              child: Text("Add Medication"),
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
        title: Text("Configure Band"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : patient == null
          ? Center(child: Text("Patient not found."))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildPatientInfoSection(),
            SizedBox(height: 16),
            _buildAddMedicationButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientInfoSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Patient Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Name: ${patient?.name} ${patient?.lastName}"),
            Text("Address: ${patient?.address}"),
            Text("Birthdate: ${patient?.birthDate}"),
          ],
        ),
      ),
    );
  }

  Widget _buildAddMedicationButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: _addMedicationSchedule,
        icon: Icon(Icons.add),
        label: Text("Add Medication"),
      ),
    );
  }
}
