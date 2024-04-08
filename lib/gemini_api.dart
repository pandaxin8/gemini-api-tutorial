import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http; 
import 'dart:convert'; // For JSON parsing


Future<Map<String, dynamic>> sendPromptToGemini(String prompt) async {
  // Replace with your actual API key and Gemini's endpoint URL
  final apiKey = dotenv.env['API_KEY'];
  final response = await http.post(Uri.parse('https://api.gemini.com/v1/generate'), 
        headers: {'Authorization': 'Bearer $apiKey'},
        body: {'prompt': prompt}); 

  if (response.statusCode == 200) {
    return jsonDecode(response.body); 
  } else {
    throw Exception('Gemini request failed');
  }
}


Future<String> generateScenario() async {
  final prompt = "We accidentally adopted a talking cat and...";
  final geminiResponse = await sendPromptToGemini(prompt);
  return geminiResponse['text']; // Adapt based on your JSON understanding
}