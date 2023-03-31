import 'dart:convert';
import 'package:http/http.dart' as http;

Future sendMessage(String message) async {
  const String baseUrl = 'https://candidate.yewubetsalone.com/api/send-message';
  final response = await http.post(
    Uri.parse(baseUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'message': message,
    }),
  );

  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to send message.');
  }
}
