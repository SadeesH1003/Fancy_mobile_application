import 'package:fancy/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://randomuser.me/api/portraits/men/32.jpg',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Admin Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'admin@example.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            _buildInfoCard('Role', 'System Administrator'),
            _buildInfoCard('Status', 'Active'),
            _buildInfoCard('Last Login', 'Today, 10:30 AM'),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 24),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MyApp()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 165, 81, 139),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Log Out",
                  style: GoogleFonts.marcellus(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(value, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
