import 'package:dio/dio.dart';
import '../../api/endpoints.dart';
import '../../models/keyword_model.dart';
import '../../models/movie_model.dart';
import '../../models/movie_response.dart';
import '../core/network/dio_client.dart';

class KeywordRepository {
  final DioClient _dioClient;

  KeywordRepository({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  Future<Keyword> getKeywordDetails(int keywordId) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.keywordDetails(keywordId));
      return Keyword.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load keyword details: $e');
    }
  }

  Future<List<Movie>> getKeywordMovies(int keywordId, {int page = 1}) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.keywordMovies(keywordId),
        queryParameters: {'page': page, 'include_adult': false, 'language': 'en-US'},
      );
      return MovieResponse.fromJson(response.data).results;
    } catch (e) {
      throw Exception('Failed to load keyword movies: $e');
    }
  }
}
