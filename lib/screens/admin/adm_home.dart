import 'package:fancy/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 165, 81, 139),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Manage your products and monitor store activity here',
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade800,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 20),
                _buildStatsColumn(),
                const SizedBox(height: 42),
              ],
            ),
            Text(
              "FANCY",
              style: GoogleFonts.marcellus(
                fontSize: 55,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 165, 81, 139),
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsColumn() {
    return Column(
      children: [
        _buildStatCard(
          icon: Icons.shopping_bag,
          title: 'Total Products',
          value: '8',
        ),
        const SizedBox(height: 16),
        _buildStatCard(
          icon: Icons.people,
          title: 'Registered Users',
          value: context.watch<AdminProvider>().users.length.toString(),
        ),
        const SizedBox(height: 16),
        _buildStatCard(icon: Icons.reviews, title: 'Reviews', value: '23'),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      height: 75,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),

      decoration: BoxDecoration(
        color: Color.fromARGB(60, 165, 81, 139),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color.fromARGB(255, 165, 81, 139)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Color.fromARGB(255, 165, 81, 139), size: 32),
              SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
