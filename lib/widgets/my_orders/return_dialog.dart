import 'package:fancy/model/order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReturnDialog extends StatelessWidget {
  final Order order;

  const ReturnDialog({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Return Items",
        style: GoogleFonts.marcellus(fontWeight: FontWeight.bold),
      ),
      content: Text(
        "Do you want to return items from order #${order.id}?",
        style: GoogleFonts.marcellus(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel", style: GoogleFonts.marcellus()),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Return request initiated. Check your email for more details.",
                  style: GoogleFonts.marcellus(),
                ),
                backgroundColor: const Color.fromARGB(255, 165, 81, 139),
              ),
            );
          },
          child: Text(
            "Request Return",
            style: GoogleFonts.marcellus(
              color: const Color.fromARGB(255, 165, 81, 139),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
