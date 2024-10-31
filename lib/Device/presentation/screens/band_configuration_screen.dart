// band_configuration_screen.dart
import 'package:flutter/material.dart';

class BandConfigurationScreen extends StatelessWidget {
  final int bandId;
  final String patientName;

  BandConfigurationScreen({required this.bandId, required this.patientName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configure Band for $patientName"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Band ID: $bandId",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "Patient: $patientName",
              style: TextStyle(fontSize: 18),
            ),
            // Aquí puedes añadir los componentes de configuración
          ],
        ),
      ),
    );
  }
}
