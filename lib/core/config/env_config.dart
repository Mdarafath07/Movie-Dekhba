import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static Future<void> loadEnv() async {
    await dotenv.load(fileName: ".env");
  }

  static String get tmdbApiKey {
    final key = dotenv.env['TMDB_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('TMDB_API_KEY not found in .env file');
    }
    return key;
  }
}
