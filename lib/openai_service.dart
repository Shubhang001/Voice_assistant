import 'dart:convert';

import 'package:chat_bot/secrets.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  Future<String> isArtPromptAPI(String prompt) async {
    try {
      
      final res = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $openAPI'
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "user",
                "content":
                    "Does this message want to generate an AI picture,image,art or anything similar? $prompt.yes or no."
              }
            ]
          }));
          print(res.body);
          if(res.statusCode ==200)
          {
            print("Result recieved correctly");
          }
          return 'Ai';
    } catch (e) {
      return e.toString();
    }
  }
}
