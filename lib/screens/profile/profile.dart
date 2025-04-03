// ignore_for_file: deprecated_member_use

import 'package:fancy/main.dart';
import 'package:fancy/providers/user_provider.dart';
import 'package:fancy/widgets/profile/account_settings_card.dart';
import 'package:fancy/widgets/profile/edit_profile_dialog.dart';
import 'package:fancy/widgets/profile/personal_info_card.dart';
import 'package:fancy/widgets/profile/profile_header.dart';
import 'package:fancy/widgets/section_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String userAddress = "123 Main Street, Colombo";

  void showEditProfileDialog() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final aboutText = "Lorem ipsum dolor sit amet...";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return EditProfileDialog(
          user: userProvider.user,
          aboutText: aboutText,
          onUpdate: (username, email, phone, about) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Profile updated successfully',
                  style: GoogleFonts.marcellus(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                backgroundColor: Color.fromARGB(255, 165, 81, 139),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Profile",
          style: GoogleFonts.marcellus(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.black,
            onPressed: showEditProfileDialog,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(
                userName: userProvider.user!.username,
                userEmail: userProvider.user!.email,
                userProfileImage: userProvider.user!.profilePictureURL,
              ),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle(title: "Personal Information"),
                    PersonalInfoCard(
                      userPhone: userProvider.user!.contactNumber,
                      userAddress: userAddress,
                    ),
                    const SizedBox(height: 24),
                    const SectionTitle(title: "Account Settings"),
                    const AccountSettingsCard(),
                    const SizedBox(height: 24),

                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 24),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<UserProvider>().logout();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const MyApp(),
                            ),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            165,
                            81,
                            139,
                          ),
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
            ],
          ),
        ),
      ),
    );
  }
}
