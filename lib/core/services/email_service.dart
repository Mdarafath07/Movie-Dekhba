import 'package:dio/dio.dart';
import '../config/email_config.dart';

class EmailService {
  final Dio _dio = Dio();

  Future<bool> sendFeedback({
    required String type,
    required String message,
    required String userEmail,
  }) async {
    try {
      final response = await _dio.post(
        'https://api.emailjs.com/api/v1.0/email/send',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'service_id': EmailConfig.serviceId,
          'template_id': EmailConfig.templateId,
          'user_id': EmailConfig.publicKey,
          'accessToken': EmailConfig.privateKey,
          'template_params': {
            'user_email': userEmail,
            'message': message,
            'type': type,
            'time': DateTime.now().toString().substring(0, 16),
            'app_name': 'Movie Dekhba',
          },
        },
      );

      print("EmailJS Response: ${response.data}");
      return response.statusCode == 200;
    } catch (e) {
      if (e is DioException) {
        print("EmailJS Error Response: ${e.response?.data}");
      }
      print("EmailJS Error: $e");
      return false;
    }
  }
}