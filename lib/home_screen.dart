import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gemini_api_tutorial/main.dart';
import 'package:gemini_api_tutorial/gemini_api.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _currentScenario = 'Loading...';

  Future<String> generateAndStoreScenario() async {
    final prompt = "We accidentally adopted a talking cat and...";
    final geminiResponse = await sendPromptToGemini(prompt); 

    // Assume Gemini gives you a 'scenario' field
    final scenarioText = geminiResponse['scenario']; 

    await FirebaseFirestore.instance.collection('scenarios').add({
      'text': scenarioText 
    });

    return scenarioText;
  }

  void _fetchScenario() async {
    try {
      final newScenario = await generateAndStoreScenario();
      setState(() {
        _currentScenario = newScenario;
      });
    } catch (error) {
       // Handle potential errors here
    } 
  }

  @override 
  void initState() {
    super.initState();
    _fetchScenario(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... appBar ...
      body: Padding( // Adds padding around the content
        padding: const EdgeInsets.all(20.0),
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center, // Centers vertically
          children: [
            Text(_currentScenario, style: TextStyle(fontSize: 20)),
            SizedBox(height: 30), 
            ElevatedButton(
              onPressed: _fetchScenario,
              child: const Text('New Scenario'),
            )
          ],
        ),
      ),
    );
  }  
}