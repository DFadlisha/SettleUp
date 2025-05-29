import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCEpS1yo7uKG7LDqRE0rMocusXK6paM1h4",
        authDomain: "settleup-24203.firebaseapp.com",
        projectId: "settleup-24203",
        storageBucket: "settleup-24203.firebasestorage.app",
        messagingSenderId: "1030394026845",
        appId: "1:1030394026845:android:8a447cc3547216d432e6b4",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F3F33),
          primary: const Color(0xFF0F3F33),
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(), // Start with login page
      routes: {
        '/login': (context) => const LoginPage(),
        //'/register': (context) => const RegisterPage(),
      },
    );
  }
}
