import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIService {
  static final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? "";
  static const String model = "gemini-2.0-flash";
  static String get url =>
      "https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey";


  static Future<String> generatePlan(String location, int days, int people) async {
    final prompt = """
Create a detailed travel itinerary:

Location: $location
Days: $days
People: $people

Include:
- Day-by-day plan
- Hourly activities
- Total budget + breakdown
- Hotels (budget)
- Food recommendations
- Weather advice
- Packing list
""";

    final body = {
      "contents": [
        {
          "parts": [{"text": prompt}]
        }
      ]
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json["candidates"][0]["content"]["parts"][0]["text"];
    } else {
      return "Error: ${response.body}";
    }
  }
}
