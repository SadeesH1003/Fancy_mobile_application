import 'package:fancy/notifications/notifications.dart';
import 'package:fancy/providers/admin_provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fancy/const.dart';
import 'package:fancy/providers/user_provider.dart';
import 'package:fancy/screens/auth/get_started_1.dart';
import 'package:fancy/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  await _setup();
  runApp(const MyApp());
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey = publishableKey;
  await Notifications().init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProvider(create: (ctx) => AdminProvider()),
      ],
      child: MaterialApp(
        title: 'Fancy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return const HomeScreen();
            }
            return const GetStarted1();
          },
        ),
      ),
    );
  }
}
