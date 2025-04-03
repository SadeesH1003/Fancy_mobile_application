// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHeader extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userProfileImage;

  const ProfileHeader({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userProfileImage,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ClipOval(
            child: Container(
              height: 150,
              width: 150,
              color: Color.fromARGB(255, 165, 81, 139),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/logo_bg.png',
                image: widget.userProfileImage,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
                placeholderFit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 500),
                fadeInCurve: Curves.easeIn,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.userName,
            style: GoogleFonts.marcellus(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.userEmail,
            style: GoogleFonts.marcellus(
              fontSize: 14,
              color: Colors.black.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
