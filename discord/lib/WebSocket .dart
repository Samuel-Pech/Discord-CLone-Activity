import 'dart:convert';
import 'package:http/http.dart' as http;

class DiscordService {
  final String token;
  late http.Client _client;

  DiscordService(this.token) {
    _client = http.Client();
  }

  Future<void> connect() async {}

  Future<void> sendMessage(String channelId, String message) async {
    final url = 'https://discord.com/api/v9/channels/$channelId/messages';
    final response = await _client.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bot $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'content': message}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al enviar mensaje: ${response.body}');
    }
  }

  void dispose() {
    _client.close();
  }
}
