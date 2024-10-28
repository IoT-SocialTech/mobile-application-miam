import 'package:flutter/material.dart';

class MonitoringScreen extends StatelessWidget {

  int _selectedIndex = 0;

  // Función que gestiona el cambio de pestaña en el BottomNavigationBar
  void _onItemTapped(int index) {
    _selectedIndex = index;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Alerts Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Alerts",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            _buildAlertCard(
              context,
              title: "High risk of falling for María Carrillo",
              description: "Immediate attention required",
              color: Colors.redAccent,
            ),
            _buildAlertCard(
              context,
              title: "High temperature recorded for José Díaz",
              description: "Current temperature: 38.5°C",
              color: Colors.orangeAccent,
            ),

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
                "2",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // General Health Status Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "General Health Status",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            _buildHealthStatus(),

            // Medication Section
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Medication",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            _buildMedicationCard(
              context,
              time: "15:00",
              patient: "María Carrillo",
              medication: "Losartan 50 mg - 1 pill",
              caregiver: "Carolina Suarez",
            ),
            _buildMedicationCard(
              context,
              time: "22:00",
              patient: "José Díaz",
              medication: "Glibenclamide 5 mg - 1/2 pill",
              caregiver: "Carolina Suarez",
            ),

            // Caregivers Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Caregivers",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<String>(
                value: "Carolina Suarez",
                onChanged: (String? newValue) {},
                items: <String>['Carolina Suarez', 'Another Caregiver']
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
              data: [37, 36, 38, 39, 37.5],
            ),
            _buildVitalSignsChart(
              context,
              title: "Heart Rate (bpm)",
              data: [80, 82, 75, 85, 90],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertCard(BuildContext context, {required String title, required String description, required Color color}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: color.withOpacity(0.1),
      child: ListTile(
        leading: Icon(Icons.warning, color: color, size: 40),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }

  Widget _buildHealthStatus() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _buildHealthStatusItem(
              label: "Temperature", status: "Follow-Up Required", color: Colors.orange),
          _buildHealthStatusItem(label: "Pulse", status: "All Stable", color: Colors.green),
          _buildHealthStatusItem(label: "Fall Risk", status: "Follow-Up Required", color: Colors.red),
        ],
      ),
    );
  }

  Widget _buildHealthStatusItem({required String label, required String status, required Color color}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
      ),
      title: Text(label),
      subtitle: Text(status),
    );
  }

  Widget _buildMedicationCard(BuildContext context, {required String time, required String patient, required String medication, required String caregiver}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        leading: Text(time),
        title: Text(patient),
        subtitle: Text(medication),
        trailing: Text("Caregiver: $caregiver"),
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
            height: 150,
            child: Placeholder(), // Aquí puedes implementar una gráfica personalizada.
          ),
        ],
      ),
    );
  }
}
