import 'package:dio/dio.dart';
import '../../api/endpoints.dart';
import '../../models/account_model.dart';
import '../../models/movie_model.dart';
import '../../models/tv_show_model.dart';
import '../core/network/dio_client.dart';
import '../models/movie_response.dart';

class AccountRepository {
  final DioClient _dioClient;

  AccountRepository({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  Future<Account> getAccountDetails(int accountId) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.accountDetails(accountId));
      return Account.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load account details: $e');
    }
  }

  Future<bool> markFavorite({
    required int accountId,
    required String mediaType, // 'movie' or 'tv'
    required int mediaId,
    required bool isFavorite,
  }) async {
    try {
      final response = await _dioClient.dio.post(
        Endpoints.markFavorite(accountId),
        data: {
          'media_type': mediaType,
          'media_id': mediaId,
          'favorite': isFavorite,
        },
      );
      
      // TMDB returns status_code 1 (Success) or 12 (The item/record was updated successfully) or 13 (The item/record was deleted successfully)
      final statusCode = response.data['status_code'];
      return statusCode == 1 || statusCode == 12 || statusCode == 13;
    } catch (e) {
      throw Exception('Failed to mark as favorite: $e');
    }
  }

  Future<List<Movie>> getFavoriteMovies({
    required int accountId,
    int page = 1,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.accountFavoriteMovies(accountId),
        queryParameters: {
          'language': 'en-US',
          'page': page.toString(),
          'sort_by': 'created_at.asc',
        },
      );
      return MovieResponse.fromJson(response.data).results;
    } catch (e) {
      throw Exception('Failed to load favorite movies: $e');
    }
  }

  Future<List<Movie>> getWatchlistMovies({
    required int accountId,
    int page = 1,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.accountWatchlistMovies(accountId),
        queryParameters: {
          'language': 'en-US',
          'page': page.toString(),
          'sort_by': 'created_at.asc',
        },
      );
      return MovieResponse.fromJson(response.data).results;
    } catch (e) {
      throw Exception('Failed to load watchlist movies: $e');
    }
  }

  Future<List<Movie>> getRatedMovies({
    required int accountId,
    int page = 1,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.accountRatedMovies(accountId),
        queryParameters: {
          'language': 'en-US',
          'page': page.toString(),
          'sort_by': 'created_at.asc',
        },
      );
      return MovieResponse.fromJson(response.data).results;
    } catch (e) {
      throw Exception('Failed to load rated movies: $e');
    }
  }

  Future<List<TvShow>> getRatedTvShows({
    required int accountId,
    int page = 1,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.accountRatedTv(accountId),
        queryParameters: {
          'language': 'en-US',
          'page': page.toString(),
          'sort_by': 'created_at.asc',
        },
      );
      return TvShowResponse.fromJson(response.data).results;
    } catch (e) {
      throw Exception('Failed to load rated tv shows: $e');
    }
  }

  Future<String> createGuestSession() async {
    try {
      final response = await _dioClient.dio.get(Endpoints.createGuestSession);
      return response.data['guest_session_id'];
    } catch (e) {
      throw Exception('Failed to create guest session: $e');
    }
  }
}
