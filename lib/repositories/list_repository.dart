import 'package:dio/dio.dart';
import '../../api/endpoints.dart';
import '../../models/list_model.dart';
import '../core/network/dio_client.dart';

class ListRepository {
  final DioClient _dioClient;

  ListRepository({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  Future<TmdbList> getListDetails(int listId, {int page = 1}) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.listDetails(listId),
        queryParameters: {'language': 'en-US', 'page': page},
      );
      return TmdbList.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load list details: $e');
    }
  }

  Future<ListItemStatus> checkItemStatus(int listId, int movieId) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.listCheckItemStatus(listId, movieId));
      return ListItemStatus.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to check item status: $e');
    }
  }

  Future<int> createList({required String sessionId, required String name, required String description, String language = 'en'}) async {
    try {
      final response = await _dioClient.dio.post(
        Endpoints.createList,
        queryParameters: {'session_id': sessionId},
        data: {'name': name, 'description': description, 'language': language},
      );
      return response.data['list_id'];
    } catch (e) {
      throw Exception('Failed to create list: $e');
    }
  }

  Future<bool> deleteList(int listId, {required String sessionId}) async {
    try {
      final response = await _dioClient.dio.delete(
        Endpoints.deleteList(listId),
        queryParameters: {'session_id': sessionId},
      );
      return response.data['status_code'] == 12;
    } catch (e) {
      throw Exception('Failed to delete list: $e');
    }
  }

  Future<bool> removeMovieFromList(int listId, int mediaId, {required String sessionId}) async {
    try {
      final response = await _dioClient.dio.post(
        Endpoints.removeMovieFromList(listId),
        queryParameters: {'session_id': sessionId},
        data: {'media_id': mediaId},
      );
      return response.data['status_code'] == 13;
    } catch (e) {
      throw Exception('Failed to remove movie from list: $e');
    }
  }
}
