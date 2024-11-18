import 'package:cabeleileila/firebase_options.dart';
import 'package:cabeleileila/view/screens/login/presentation/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CL Agendamentos',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const LoginScreen(),
    );
  }
}
