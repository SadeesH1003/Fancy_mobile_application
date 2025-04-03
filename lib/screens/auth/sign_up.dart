import 'package:fancy/main.dart';
import 'package:fancy/model/user.dart';
import 'package:fancy/providers/user_provider.dart';
import 'package:fancy/widgets/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      print('Name: ${_usernameController.text}');
      print('Contact Number: ${_contactNumberController.text}');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');

      final userProvider = context.read<UserProvider>();
      if (userProvider.profileImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please select a profile image',
              textAlign: TextAlign.center,
              style: GoogleFonts.marcellus(fontWeight: FontWeight.normal),
            ),
            backgroundColor: Color.fromARGB(255, 165, 81, 139),
          ),
        );
        return;
      }

      try {
        User user = User(
          uid: "",
          username: _usernameController.text,
          email: _emailController.text,
          contactNumber: _contactNumberController.text,
          profilePictureURL: "",
        );

        await context.read<UserProvider>().registerUser(
          user,
          _passwordController.text,
        );

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MyApp()),
          (route) => false,
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Registration failed: ${error.toString()}',
              style: GoogleFonts.marcellus(color: Colors.white),
            ),
            backgroundColor: Color.fromARGB(255, 207, 79, 79),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _contactNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/206813471_75f9a78b-b98f-4194-b683-beafc10c3cd9.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: screenSize.height - 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        spacing: 16,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign Up',
                            style: GoogleFonts.marcellus(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Color.fromARGB(255, 165, 81, 139),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Column(
                        spacing: 16,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          UserImagePicker(onPickedImage: (pickedImage) {}),
                          TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: GoogleFonts.marcellus(
                                color: Color.fromARGB(255, 165, 81, 139),
                              ),
                              prefixIcon: Icon(Icons.person),
                              prefixIconColor: Color.fromARGB(
                                255,
                                165,
                                81,
                                139,
                              ),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 165, 81, 139),
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 165, 81, 139),
                                  width: 2.5,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a username';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _contactNumberController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Contact Number',
                              labelStyle: GoogleFonts.marcellus(
                                color: Color.fromARGB(255, 165, 81, 139),
                              ),
                              prefixIcon: Icon(Icons.phone),
                              prefixIconColor: Color.fromARGB(
                                255,
                                165,
                                81,
                                139,
                              ),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 165, 81, 139),
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 165, 81, 139),
                                  width: 2.5,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your contact number';
                              }
                              if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                return 'Please enter a valid 10-digit phone number';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hoverColor: Color.fromARGB(255, 165, 81, 139),
                              labelText: 'Email',
                              labelStyle: GoogleFonts.marcellus(
                                color: Color.fromARGB(255, 165, 81, 139),
                              ),
                              prefixIcon: Icon(Icons.email),
                              prefixIconColor: Color.fromARGB(
                                255,
                                165,
                                81,
                                139,
                              ),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 165, 81, 139),
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 165, 81, 139),
                                  width: 2.5,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              bool emailValid = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                              ).hasMatch(value);
                              if (!emailValid) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: GoogleFonts.marcellus(
                                color: Color.fromARGB(255, 165, 81, 139),
                              ),
                              prefixIcon: const Icon(Icons.lock),
                              prefixIconColor: Color.fromARGB(
                                255,
                                165,
                                81,
                                139,
                              ),
                              border: const OutlineInputBorder(),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 165, 81, 139),
                                  width: 2,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 165, 81, 139),
                                  width: 2.5,
                                ),
                              ),
                              suffixIconColor: Color.fromARGB(
                                255,
                                165,
                                81,
                                139,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          ElevatedButton(
                            onPressed: _handleSignUp,

                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              fixedSize: Size(screenSize.width, 58),

                              backgroundColor:
                                  context.watch<UserProvider>().isLoading
                                      ? Colors.grey
                                      : Color.fromARGB(255, 165, 81, 139),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child:
                                context.watch<UserProvider>().isLoading
                                    ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                    : Text(
                                      'Sign Up',
                                      style: GoogleFonts.marcellus(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            height: 2,
                            width: screenSize.width,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 165, 81, 139),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: RichText(
                              text: TextSpan(
                                style: GoogleFonts.marcellus(
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(text: "Already have an account? "),
                                  TextSpan(
                                    text: "Sign In",
                                    style: GoogleFonts.marcellus(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            "By registering you agree to our\nTerms & Privacy Policy",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.marcellus(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
