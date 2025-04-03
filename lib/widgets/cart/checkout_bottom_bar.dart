// ignore_for_file: deprecated_member_use

import 'package:fancy/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckoutBottomBar extends StatelessWidget {
  final double total;
  final VoidCallback onPayPressed;

  const CheckoutBottomBar({
    super.key,
    required this.total,
    required this.onPayPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: GoogleFonts.marcellus(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Rs.${total.toStringAsFixed(2)}',
                style: GoogleFonts.marcellus(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 165, 81, 139),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onPayPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  context.watch<UserProvider>().isLoading
                      ? Colors.grey
                      : const Color.fromARGB(255, 165, 81, 139),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child:
                context.watch<UserProvider>().isLoading
                    ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                    : Text(
                      'Pay Now',
                      style: GoogleFonts.marcellus(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
