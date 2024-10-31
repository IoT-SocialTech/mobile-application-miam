import 'package:flutter/material.dart';
import 'band_configuration_screen.dart'; // Importa la pantalla de configuración

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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BandConfigurationScreen(bandId: band['id'], patientName: band['patientName']),
          ),
        );
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
}
