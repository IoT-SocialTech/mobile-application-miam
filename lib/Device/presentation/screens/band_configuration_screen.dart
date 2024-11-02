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
        child: ListView(
          children: [
            _buildPatientInfoSection(),
            SizedBox(height: 16),
            Text(
              "Caregiver",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildCaregiverSection(),
            SizedBox(height: 16),
            Text(
              "Relative",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildRelativeSection(),
            SizedBox(height: 16),
            _buildResetButton(),
            SizedBox(height: 20),
            _buildSaveButton(),
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
              "Patient",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Name: $patientName"),
          ],
        ),
      ),
    );
  }

  Widget _buildCaregiverSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Assigned to: Carolina Suarez"),
            SizedBox(height: 16),
            Text("Alerts:", style: TextStyle(fontWeight: FontWeight.bold)),
            Divider(),
            _buildAlertCheckbox("Alert if temperature is below", "°C", "4"),
            Divider(),
            _buildAlertCheckbox("Alert if pulse is below", "bpm", "2"),
            Divider(),
            CheckboxListTile(
              title: Text("Alert me if fall risk is high"),
              value: false,
              onChanged: (value) {},
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelativeSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Divider(),
            _buildAlertCheckbox("Alert if temperature is below", "°C", "1"),
            Divider(),
            _buildAlertCheckbox("Alert if pulse is below", "bpm", "3"),
            Divider(),
            CheckboxListTile(
              title: Text("Alert me if fall risk is high"),
              value: false,
              onChanged: (value) {},
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertCheckbox(String title, String unit, String defaultValue) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(value: false, onChanged: (value) {}),
        Expanded(
          child: Text(title),
        ),
        SizedBox(width: 8),
        _buildInputField(defaultValue),
        SizedBox(width: 5),
        Text(unit),
        SizedBox(width: 10),
        Text("or higher than"),
        SizedBox(width: 10),
        _buildInputField(defaultValue),
        SizedBox(width: 5),
        Text(unit),
      ],
    );
  }

  Widget _buildInputField(String defaultValue) {
    return SizedBox(
      width: 40,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
          isDense: true,
          hintText: defaultValue,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
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



