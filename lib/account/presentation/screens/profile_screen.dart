import 'package:flutter/material.dart';
import 'package:miam_flutter/account/domain/repositories/caregiver_repository.dart';
import 'package:miam_flutter/account/application/bloc_or_cubit/login_cubit.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? caregiverData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCaregiverDetails();
  }

  Future<void> _fetchCaregiverDetails() async {
    try {
      final caregiverRepository = CaregiverRepository();
      final accountId = await getUserId() ?? 0; // Obtén el ID del usuario actual
      final caregiver = await caregiverRepository.getCaregiverByAccountId(accountId);

      setState(() {
        caregiverData = {
          "name": caregiver.name,
          "role": caregiver.account.role.description,
          "subscription": caregiver.account.subscription.type,
          "createdAt": caregiver.account.createdAt.split("T")[0],
        };
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching profile: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : caregiverData == null
          ? Center(child: Text("No profile data available."))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileField("Name", caregiverData!['name']),
            _buildProfileField("Role", caregiverData!['role']),
            _buildProfileField("Subscription", caregiverData!['subscription']),
            _buildProfileField("Created At", caregiverData!['createdAt']),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
