import 'package:dio/dio.dart';
import '../api/endpoints.dart';
import '../core/network/dio_client.dart';
import '../models/movie_response.dart';
import '../models/person_model.dart';
import '../models/search_multi_model.dart';
import '../models/tv_show_model.dart';

/// Valid values for the [timeWindow] parameter on all trending endpoints.
class TrendingTimeWindow {
  static const String day = 'day';
  static const String week = 'week';
}

/// Repository covering the four TMDB /trending/* endpoints.
class TrendingRepository {
  final DioClient _dioClient;

  TrendingRepository({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  // Trending All
  Future<MultiSearchResponse> getTrendingAll(
    String timeWindow, {
    String language = 'en-US',
  }) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.trendingAll(timeWindow),
        queryParameters: {'language': language},
      );
      return MultiSearchResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load trending all: ${e.message}');
    }
  }

  // Trending Movies
  Future<MovieResponse> getTrendingMovies(
    String timeWindow, {
    String language = 'en-US',
  }) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.trendingMoviesByWindow(timeWindow),
        queryParameters: {'language': language},
      );
      return MovieResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load trending movies: ${e.message}');
    }
  }

  // Trending People
  Future<PersonResponse> getTrendingPeople(
    String timeWindow, {
    String language = 'en-US',
  }) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.trendingPeople(timeWindow),
        queryParameters: {'language': language},
      );
      return PersonResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load trending people: ${e.message}');
    }
  }

  // Trending TV
  Future<TvShowResponse> getTrendingTv(
    String timeWindow, {
    String language = 'en-US',
  }) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.trendingTvByWindow(timeWindow),
        queryParameters: {'language': language},
      );
      return TvShowResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load trending TV: ${e.message}');
    }
  }
}
