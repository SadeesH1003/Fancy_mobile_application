import 'package:fancy/main.dart';
import 'package:fancy/providers/user_provider.dart';
import 'package:fancy/screens/auth/sign_up.dart';
import 'package:fancy/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        final userProvider = context.read<UserProvider>();
        await userProvider.loginUser(
          _emailController.text.trim(),
          _passwordController.text,
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MyApp()),
          (route) => false,
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
                  width: double.infinity,
                  height: screenSize.height - 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        spacing: 16,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sign In',
                            style: GoogleFonts.marcellus(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Color.fromARGB(255, 165, 81, 139),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "FANCY",
                            style: GoogleFonts.marcellus(
                              fontSize: 55,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Column(
                        spacing: 8,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                              if (!_isValidEmail(value)) {
                                return 'Please enter a valid email';
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
                          //
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: _handleLogin,
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(screenSize.width, 58),
                              backgroundColor:
                                  context.watch<UserProvider>().isLoading
                                      ? Colors.grey
                                      : Color.fromARGB(255, 165, 81, 139),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
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
                                      'Sign In',
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
                            height: 2,
                            width: screenSize.width,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 165, 81, 139),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (ctx) => SignUp()),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                style: GoogleFonts.marcellus(
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(text: "Don't have an account ? "),
                                  TextSpan(
                                    text: "Sign Up",
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
                            "By continue you agree to our\nTerms & Privacy Policy",
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
