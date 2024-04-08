import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';  // For Firebase integration
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini_api_tutorial/firebase_options.dart';
import 'package:gemini_api_tutorial/home_screen.dart'; // For loading API keys 
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:http/http.dart' as http; 
import 'dart:convert'; 
import 'package:gemini_api_tutorial/gemini_api.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for Flutter
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,); // Initialize Firebase
  await dotenv.load(fileName: "../.env");
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oops, We Got Married!',
      theme: ThemeData(
        // Your theme choices here 
      ),
      home: const HomeScreen(), // Or your initial starting screen
    );
  }
}
