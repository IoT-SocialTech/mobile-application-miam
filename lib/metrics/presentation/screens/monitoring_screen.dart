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

            // Caregivers Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Patients",
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
