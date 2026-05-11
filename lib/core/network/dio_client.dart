import 'package:dio/dio.dart';
import '../../api/endpoints.dart';

class DioClient {
  final Dio _dio;

  DioClient()
      : _dio = Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${Endpoints.apiKey}',
            },
          ),
        );

  Dio get dio => _dio;
}
