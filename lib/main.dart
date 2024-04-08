import 'dart:io'; // Likely not needed for Flutter
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; 
import 'package:http/http.dart' as http; // For making API calls
import 'dart:convert'; // For working with JSON
import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
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
                child: const Text('New Scenario'),
                onPressed: _fetchScenario, 
              ),
            ],
          ),
        ), 
      ), 
    );
  }
}