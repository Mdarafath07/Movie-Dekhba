import '../api/endpoints.dart';
import '../models/network_model.dart';
import '../core/network/dio_client.dart';

class NetworkRepository {
  final DioClient _dioClient;

  NetworkRepository({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  Future<Network> getNetworkDetails(int id) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.networkDetails(id));
      return Network.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load network details: $e');
    }
  }

  Future<NetworkAlternativeNamesResponse> getAlternativeNames(int id) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.networkAlternativeNames(id));
      return NetworkAlternativeNamesResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load network alternative names: $e');
    }
  }

  Future<NetworkImagesResponse> getImages(int id) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.networkImages(id));
      return NetworkImagesResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load network images: $e');
    }
  }
}
