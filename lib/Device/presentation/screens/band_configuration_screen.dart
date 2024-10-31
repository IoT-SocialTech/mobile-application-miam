import 'package:flutter/material.dart';

class BandConfigurationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Band Configuration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            _buildBandInfoCard(),
            _buildPatientInfoCard(),
            _buildCaregiverInfoCard(),
            _buildRelativeInfoCard(),
            _buildResetButton(),
            SizedBox(height: 20),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBandInfoCard() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ID: 1       Status: Synchronized",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Battery: 80%"),
            Text("Last Sync: 2024-09-18 18:05"),
            TextButton(
              onPressed: () {},
              child: Text(
                "Sync now",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientInfoCard() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Patient",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Name: Carlos"),
          ],
        ),
      ),
    );
  }

  Widget _buildCaregiverInfoCard() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Caregiver",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Assigned to: Carolina Suarez"),
            SizedBox(height: 16),
            Text("Alerts:", style: TextStyle(fontWeight: FontWeight.bold)),
            CheckboxListTile(
              title: Text("Alert if temperature is below"),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text("Alert if pulse is below"),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text("Alert me if fall risk is high"),
              value: false,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelativeInfoCard() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Relative",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Related to: Carolina Suarez"),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Colors.red),
                  label: Text(
                    "Remove relative",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text("Alerts:", style: TextStyle(fontWeight: FontWeight.bold)),
            CheckboxListTile(
              title: Text("Alert if temperature is below"),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text("Alert if pulse is below"),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text("Alert me if fall risk is high"),
              value: false,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResetButton() {
    return Center(
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(Icons.delete, color: Colors.red),
        label: Text(
          "Reset band",
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Acción para guardar la configuración
        },
        child: Text("Save"),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(150, 50),
        ),
      ),
    );
  }
}
