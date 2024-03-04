import 'package:finalprojectsportsquiz/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCN4YJN51cSCgasVrQYuUKt2CRT1JPTKIw",
      appId: "1:699249260469:android:0df52a1e23cf943c608bfc",
      messagingSenderId: "699249260469",
      projectId: "finalprojectsportsquiz",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'PK Uttaradit',
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.red,
          hintColor: Colors.amber),
      title: 'The Great Finale Project',
      home: HomeScreen(),
    );
  }
}
