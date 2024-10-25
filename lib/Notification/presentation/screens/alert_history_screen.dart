import 'package:flutter/material.dart';

class AlertHistoryScreen extends StatefulWidget {
  @override
  _AlertHistoryScreenState createState() => _AlertHistoryScreenState();
}

class _AlertHistoryScreenState extends State<AlertHistoryScreen> {
  int _selectedIndex = 2; // Inicializa en la pestaña de 'Notifications'

  final List<Map<String, String>> alerts = [
    {
      'date': '2024-09-24',
      'hour': '09:49 AM',
      'patient': 'María Carrillo',
      'alertType': 'High risk of falling',
      'description': 'Increased risk of falling',
      'caregiver': 'Carolina Suarez',
    },
    {
      'date': '2024-09-24',
      'hour': '08:52 AM',
      'patient': 'José Díaz',
      'alertType': 'High temperature',
      'description': 'Current temperature: 38.5°C',
      'caregiver': 'Carolina Suarez',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Manejar navegación según el índice seleccionado
    if (index == 0) {
      // Navegar al Dashboard
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else if (index == 1) {
      // Navegar a la pantalla de Security
      Navigator.pushReplacementNamed(context, '/security');
    } else if (index == 2) {
      // Navegar a la pantalla de Notifications (actual)
    } else if (index == 3) {
      Scaffold.of(context).openDrawer(); // Abre el Drawer para el menú
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alerts History"),
      ),
      drawer: _buildDrawer(), // Menu Drawer para la opción de menú
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: alerts.length,
          itemBuilder: (context, index) {
            final alert = alerts[index];
            return _buildAlertCard(context, alert);
          },
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shield),
            label: 'Security',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu), // Menu Hamburguesa
            label: 'Menu',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildAlertCard(BuildContext context, Map<String, String> alert) {
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
                  "Date: ${alert['date']}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Hour: ${alert['hour']}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text("Patient: ${alert['patient']}"),
            SizedBox(height: 8),
            Text("Alert Type: ${alert['alertType']}"),
            SizedBox(height: 8),
            Text("Description: ${alert['description']}"),
            SizedBox(height: 8),
            Text("Caregiver: ${alert['caregiver']}"),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  _showAlertDetails(context, alert);
                },
                icon: Icon(Icons.info),
                label: Text("More Info"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Color actualizado
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para mostrar detalles de la alerta
  void _showAlertDetails(BuildContext context, Map<String, String> alert) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Date: ${alert['date']}"),
            Text("Hour: ${alert['hour']}"),
            Text("Patient: ${alert['patient']}"),
            Text("Alert Type: ${alert['alertType']}"),
            Text("Description: ${alert['description']}"),
            Text("Caregiver: ${alert['caregiver']}"),
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

  // Drawer para el menú
  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_support),
            title: Text('Support'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
