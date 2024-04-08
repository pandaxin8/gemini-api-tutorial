import 'dart:io'; // Likely not needed for Flutter
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini_api_tutorial/firebase_options.dart'; 
import 'package:http/http.dart' as http; // For making API calls
import 'dart:convert'; // For working with JSON
import 'package:google_generative_ai/google_generative_ai.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize Flutter
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );              // Initialize Firebase
  await dotenv.load(fileName: "../.env");
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oops, We Got Married!',
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String _scenario = 'Loading...';
  bool _isLoading = false;
  List<String> _options = [];
  List<String> _players = ['john','sally'];
  List<String> _interests = ['sport', 'music'];
  List<String> _moods = ['happy','silly'];

  // Assuming `dotenv.env['API_KEY']` holds your Gemini API key
  final apiKey = dotenv.env['API_KEY'];

  Future<void> _fetchScenario() async {
    final apiKey = dotenv.env['API_KEY'];
    setState(() { _isLoading = true; });

    if (apiKey == null) {
    print('No \$API_KEY environment variable');
    exit(1);
  }
    
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

    final players = ['john', 'sally'];
    final interests = ['career', 'gaming', 'gym'];
    final moods = ['silly', 'sarcastic'];
    
    final content = [Content.text(
    """
    This is a lighthearted storytelling social game with unexpected twists called "Oops, we got married" about couples or friends. We want to generate funny and unexpected scenarios that spark playful interactions between the players.
    Player names are ${players[0]} and ${players[1]}.
    Their previous conversations have hints of a shared interest in ${interests[0]}, ${interests[1]}, ${interests[2]}. 
    They tend to be in these moods: ${moods[0]}, ${moods[1]}.
    Please create a scenario where their differing personalities clash in a humorous way, leading to multiple choices about how they'll navigate the situation. The scenario should be something they might encounter in their early days of unexpected marriage.
    Format your response as a JSON response string where you provide the scenario in one paragraph or less. Then you have the options 2-3 of them. So two fields in the JSON response: scenario (string), options (array of string).
    """
    )];
    final response = await model.generateContent(content);
    setState(() {
          _scenario = response.text ?? '';
      });
    
  }

  Future<void> generateAndStoreScenario() async {
    final apiKey = dotenv.env['API_KEY'];
    setState(() { _isLoading = true; });

    if (apiKey == null) {
    print('No \$API_KEY environment variable');
    exit(1);
  }
    
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

    final players = ['john', 'sally'];
    final interests = ['career', 'gaming', 'gym'];
    final moods = ['silly', 'sarcastic'];
    
    final content = [Content.text(
    """
    This is a lighthearted storytelling social game with unexpected twists called "Oops, we got married" about couples or friends. We want to generate funny and unexpected scenarios that spark playful interactions between the players.
    Player names are ${players[0]} and ${players[1]}.
    Their previous conversations have hints of a shared interest in ${interests[0]}, ${interests[1]}, ${interests[2]}. 
    They tend to be in these moods: ${moods[0]}, ${moods[1]}.
    Please create a scenario where their differing personalities clash in a humorous way, leading to multiple choices about how they'll navigate the situation. The scenario should be something they might encounter in their early days of unexpected marriage.
    Format your response as a JSON response string (without ``` or 'json', just start with the json) where you provide the scenario in one paragraph or less. Then you have the options 2-3 of them. So two fields in the JSON response: scenario (string), options (array of string).
    """
    )];
    final response = await model.generateContent(content);
    setState(() {
          _scenario = response.text ?? '';
      });
    
      // 3. Process Gemini Response (Example)
      final geminiResponse = jsonDecode(_scenario); // Assuming response.body is the JSON string
      print('geminiResponse: $geminiResponse');
      final scenario = geminiResponse['scenario']; 
      final options = geminiResponse['options'];

      // Check if Firebase is initialized
      if (Firebase.apps.isEmpty) {
        print('Firebase has not been initialized.');
        return; // Exit the function if not initialized
      }

      // 4. Firestore Interaction
      await FirebaseFirestore.instance.collection('scenarios').add({
      "scenario": scenario,
      "options": options,
      "players": _players, 
      "interests": _interests,
      "moods": _moods, 
    
     });

  }
  

  Future<void> fetchScenarioFromFirestore() async {
    setState(() { _isLoading = true; });

    try {
      // 1. Fetch a random scenario (for simplicity)
      final querySnapshot = await FirebaseFirestore.instance.collection('scenarios').get();
      final allScenarios = querySnapshot.docs;
      final randomScenarioDoc = allScenarios[Random().nextInt(allScenarios.length)]; // Adjust for robust selection later

      if (randomScenarioDoc.exists) {
        final data = randomScenarioDoc.data();
        setState(() {
          _scenario = data['scenario'];
          _options = data['options'].cast<String>(); // Assuming 'options' is a list of Strings
          // ... Update state with players, interests, moods if needed ...
          _players = data['players'].cast<String>();
          _interests = data['intersts'].cast<String>();
          _moods = data['moods'].cast<String>();
        });
      }

    } catch (error) {
      // ... Handle errors ...
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Game')),
      body: Center( 
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded( // Allow Text to take up the available space 
                child: SingleChildScrollView( // Make content scrollable
                  child: Text(_scenario, style: const TextStyle(fontSize: 18)), // Adjust font size as needed
                ),
              ),
              const SizedBox(height: 20),
              if (_isLoading) const CircularProgressIndicator(),
              ElevatedButton(
                child: const Text('Generate + Store'),
                onPressed: generateAndStoreScenario,
              ),
            ],
          ),
        ), 
      ), 
    );
  }
}