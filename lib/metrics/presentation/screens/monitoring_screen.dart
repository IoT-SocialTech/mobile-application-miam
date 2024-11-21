import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:miam_flutter/metrics/domain/repositories/feing_client_repository.dart';
import 'package:miam_flutter/account/domain/repositories/caregiver_repository.dart';
import 'package:miam_flutter/Device/domain/repositories/patient_caregiver_repository.dart';
import 'package:miam_flutter/account/application/bloc_or_cubit/login_cubit.dart';

class MonitoringScreen extends StatefulWidget {
  @override
  _MonitoringScreenState createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  String? selectedCaregiverName;
  int? patientsLength;
  String? selectedPatient;
  List<double> temperatureData = [];
  List<double> heartRateData = [];
  Timer? _timer;
  Map<String, int> patientsMap = {};

  @override
  void initState() {
    super.initState();
    _fetchCaregiverAndPatients(); // Obtiene pacientes y selecciona uno por defecto
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchCaregiverAndPatients() async {
    try {
      final caregiverRepository = CaregiverRepository();
      final patientRepository = PatientCaregiverRepository();
      int accountId = await getUserId() ?? 0;

      // Obtener datos del cuidador
      final caregiver = await caregiverRepository.getCaregiverByAccountId(accountId);
      final caregiverName = caregiver.name;

      // Obtener pacientes asociados
      final patientsList = await patientRepository.getPatientsByCaregiverId(caregiver.id);
      //print("Patients: $patientsList");
      //print("Patients cantidad: ${patientsList.length}");
      setState(() {
        selectedCaregiverName = caregiverName;
        patientsLength = patientsList.length;
        patientsMap = {for (var patient in patientsList) patient.name: patient.id};
        if (patientsMap.isNotEmpty) {
          selectedPatient = patientsMap.keys.first; // Selecciona el primer paciente por defecto
          _startVitalSignsUpdate(patientsMap[selectedPatient]!); // Inicia la actualización
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching caregiver or patients: ${e.toString()}")),
      );
    }
  }

  void _startVitalSignsUpdate(int patientId) {
    _timer?.cancel(); // Cancela el timer anterior si existe
    final repository = FeingClientRepository();

    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      try {
        final temperatureResponse = await repository.getTemperature(patientId);
        final heartRateResponse = await repository.getHeartRate(patientId);

        setState(() {
          temperatureData.add(temperatureResponse.temperature);
          heartRateData.add(heartRateResponse.heartRate.toDouble());

          // Limitar a un máximo de 10 puntos en cada gráfica
          if (temperatureData.length > 10) temperatureData.removeAt(0);
          if (heartRateData.length > 10) heartRateData.removeAt(0);
        });
      } catch (e) {
        print("Error fetching vital signs: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Patients Section
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Total Patients",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                "${patientsLength}",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Caregiver Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Caregiver: $selectedCaregiverName !",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            // Patients Dropdown
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<String>(
                value: selectedPatient,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPatient = newValue;

                    // Buscar el ID del paciente seleccionado y reiniciar actualizaciones
                    int? selectedPatientId = patientsMap[newValue];
                    if (selectedPatientId != null) {
                      _startVitalSignsUpdate(selectedPatientId);
                    }
                  });
                },
                items: patientsMap.keys
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),

            // Vital Signs Monitoring Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Vital Signs Monitoring",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            _buildVitalSignsChart(
              context,
              title: "Temperature (°C)",
              data: temperatureData,
            ),
            _buildVitalSignsChart(
              context,
              title: "Heart Rate (bpm)",
              data: heartRateData,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalSignsChart(BuildContext context, {required String title, required List<double> data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            child: SfCartesianChart(
              primaryXAxis: NumericAxis(
                title: AxisTitle(text: 'Time (s)'),
              ),
              primaryYAxis: NumericAxis(
                title: AxisTitle(text: title),
              ),
              series: <LineSeries<double, int>>[
                LineSeries<double, int>(
                  dataSource: data,
                  xValueMapper: (double value, int index) => index,
                  yValueMapper: (double value, int index) => value,
                  color: Colors.blue,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
