import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyOrdersView extends StatelessWidget {
  const EmptyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            "No orders found",
            style: GoogleFonts.marcellus(fontSize: 18, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
