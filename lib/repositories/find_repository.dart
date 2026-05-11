import 'package:dio/dio.dart';
import '../../api/endpoints.dart';
import '../../models/find_model.dart';
import '../core/network/dio_client.dart';

class FindRepository {
  final DioClient _dioClient;

  FindRepository({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  Future<FindResponse> findById(String externalId, String externalSource) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.findById(externalId, externalSource));
      return FindResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to find by ID: $e');
    }
  }
}
