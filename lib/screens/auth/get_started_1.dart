// ignore_for_file: deprecated_member_use
import 'package:fancy/screens/auth/get_started_2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStarted1 extends StatefulWidget {
  const GetStarted1({super.key});

  @override
  State<GetStarted1> createState() => _GetStarted1State();
}

class _GetStarted1State extends State<GetStarted1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/fc08582a7dac820a48e90ead75307705.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "FANCY",
                        style: GoogleFonts.marcellus(
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 40),

                      Text(
                        "Discover the new",
                        style: GoogleFonts.marcellus(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.4),
                              offset: const Offset(1, 1),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "world of fashion",
                        style: GoogleFonts.marcellus(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 165, 81, 139),
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.4),
                              offset: const Offset(1, 1),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GetStarted2(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 5,
                        shadowColor: Colors.black.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Let's Explore",
                            style: GoogleFonts.marcellus(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: const Color.fromARGB(255, 165, 81, 139),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: Color.fromARGB(255, 165, 81, 139),
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
