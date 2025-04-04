import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fancy/providers/user_provider.dart';
import 'package:fancy/screens/admin/adm_home.dart';
import 'package:fancy/screens/admin/adm_profile.dart';
import 'package:fancy/screens/admin/adm_reviews.dart';
import 'package:fancy/screens/admin/adm_users.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminBase extends StatefulWidget {
  const AdminBase({super.key});

  @override
  State<AdminBase> createState() => _AdminBaseState();
}

class _AdminBaseState extends State<AdminBase> {
  List<Widget> screens = [
    AdminHomeScreen(),
    AdminUsersScreen(),
    AdminReviewsScreen(),
    AdminProfileScreen(),
  ];
  int _screenIndex = 0;
  void changeScreen(int index) {
    setState(() {
      _screenIndex = index;
    });
  }

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  Future<void> _getUserInfo() async {
    if (context.read<UserProvider>().user == null) {
      await context.read<UserProvider>().getUserData();
      print(
        "Image URL ${context.read<UserProvider>().user!.profilePictureURL}",
      );
      print("Email ${context.read<UserProvider>().user!.email}");
      print("Name ${context.read<UserProvider>().user!.username}");
      print("Phone ${context.read<UserProvider>().user!.contactNumber}");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return context.watch<UserProvider>().isLoading
        ? Scaffold(
          body: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/206813471_75f9a78b-b98f-4194-b683-beafc10c3cd9.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "FANCY",
                  style: GoogleFonts.marcellus(
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: size.width * 0.45,
                  child: LinearProgressIndicator(
                    color: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        )
        : Scaffold(
          backgroundColor: Colors.white,
          body: screens[_screenIndex],
          bottomNavigationBar: ConvexAppBar(
            style: TabStyle.reactCircle,
            backgroundColor: Color.fromARGB(255, 165, 81, 139),
            items: [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.people, title: 'Users'),
              TabItem(icon: Icons.reviews, title: 'Reviews'),
              TabItem(icon: Icons.person, title: 'Profile'),
            ],
            onTap: (int i) {
              changeScreen(i);
            },
          ),
        );
  }
}
