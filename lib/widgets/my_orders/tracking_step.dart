import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackingStep extends StatelessWidget {
  final String step;
  final bool completed;
  final String date;

  const TrackingStep({
    super.key,
    required this.step,
    required this.completed,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  completed
                      ? const Color.fromARGB(255, 165, 81, 139)
                      : Colors.grey.shade300,
            ),
            child:
                completed
                    ? const Icon(Icons.check, color: Colors.white, size: 16)
                    : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step,
                  style: GoogleFonts.marcellus(
                    fontWeight: completed ? FontWeight.bold : FontWeight.normal,
                    color: completed ? Colors.black : Colors.grey,
                  ),
                ),
                if (date.isNotEmpty)
                  Text(
                    date,
                    style: GoogleFonts.marcellus(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
