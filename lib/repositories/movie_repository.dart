import 'package:dio/dio.dart';
import '../../api/endpoints.dart';
import '../../models/movie_model.dart';
import '../../models/movie_detail_model.dart';
import '../../models/movie_response.dart';
import '../models/change_model.dart';
import '../models/movie_misc_models.dart';
import '../models/keyword_model.dart';
import '../models/release_dates_model.dart';
import '../models/review_model.dart';
import '../models/video_model.dart';
import '../models/watch_provider_model.dart';
import '../core/network/dio_client.dart';

class MovieRepository {
  final DioClient _dioClient;

  MovieRepository({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  Future<List<Movie>> getTrendingMovies() async {
    try {
      final response = await _dioClient.dio.get(Endpoints.trendingMovies);
      return MovieResponse.fromJson(response.data).results;
    } on DioException catch (e) {
      throw Exception('Failed to load trending movies: ${e.message}');
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    try {
      final response = await _dioClient.dio.get(Endpoints.popularMovies);
      return MovieResponse.fromJson(response.data).results;
    } catch (e) {
      throw Exception('Failed to load popular movies: $e');
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    try {
      final response = await _dioClient.dio.get(Endpoints.topRatedMovies);
      return MovieResponse.fromJson(response.data).results;
    } catch (e) {
      throw Exception('Failed to load top rated movies: $e');
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    try {
      final response = await _dioClient.dio.get(Endpoints.upcomingMovies);
      return MovieResponse.fromJson(response.data).results;
    } catch (e) {
      throw Exception('Failed to load upcoming movies: $e');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.searchMovies(query));
      return MovieResponse.fromJson(response.data).results;
    } catch (e) {
      throw Exception('Failed to search movies: $e');
    }
  }

  Future<MovieDetail> getMovieDetails(int id, {String appendToResponse = ''}) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.movieDetails(id, appendToResponse: appendToResponse));
      return MovieDetail.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }

  Future<ChangesResponse> getMovieChanges(int movieId, {String? startDate, String? endDate, int page = 1}) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.movieChanges(movieId, startDate: startDate, endDate: endDate, page: page));
      return ChangesResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load movie changes: $e');
    }
  }

  Future<AlternativeTitlesResponse> getAlternativeTitles(int movieId, {String? country}) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.movieAlternativeTitles(movieId, country: country));
      return AlternativeTitlesResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load alternative titles: $e');
    }
  }

  Future<ExternalIds> getExternalIds(int movieId) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.movieExternalIds(movieId));
      return ExternalIds.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load external ids: $e');
    }
  }

  Future<MovieImages> getImages(int movieId, {String? includeImageLanguage, String? language}) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.movieImages(movieId, includeImageLanguage: includeImageLanguage, language: language));
      return MovieImages.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load movie images: $e');
    }
  }

  Future<AccountState> getAccountStates(int movieId, {String? sessionId, String? guestSessionId}) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.movieAccountStates(movieId, sessionId: sessionId, guestSessionId: guestSessionId));
      return AccountState.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load account states: $e');
    }
  }

  Future<MovieKeywordsResponse> getKeywords(int movieId) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.movieKeywords(movieId));
      return MovieKeywordsResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load keywords: $e');
    }
  }

  Future<ReleaseDatesResponse> getReleaseDates(int movieId) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.movieReleaseDates(movieId));
      return ReleaseDatesResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load release dates: $e');
    }
  }

  Future<ReviewResponse> getReviews(int movieId, {int page = 1}) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.movieReviews(movieId, page: page));
      return ReviewResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load reviews: $e');
    }
  }

  Future<VideoResponse> getVideos(int movieId, {String language = 'en-US'}) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.movieVideos(movieId) + '?language=$language');
      return VideoResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load videos: $e');
    }
  }

  Future<WatchProvidersResponse> getWatchProviders(int movieId) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.movieWatchProviders(movieId));
      return WatchProvidersResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load watch providers: $e');
    }
  }

  Future<List<Movie>> getSimilarMovies(int id, {int page = 1}) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.similarMovies(id) + '?page=$page');
      return MovieResponse.fromJson(response.data).results;
    } catch (e) {
      throw Exception('Failed to load similar movies: $e');
    }
  }

  Future<List<Genre>> getMovieGenres() async {
    try {
      final response = await _dioClient.dio.get(Endpoints.movieGenres);
      final List<dynamic> genresJson = response.data['genres'];
      return genresJson.map((json) => Genre.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load movie genres: $e');
    }
  }

  Future<List<Movie>> discoverMovies({int page = 1}) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.discoverMovies,
        queryParameters: {
          'include_adult': 'false',
          'include_video': 'false',
          'language': 'en-US',
          'page': page.toString(),
          'sort_by': 'popularity.desc',
        },
      );
      return MovieResponse.fromJson(response.data).results;
    } catch (e) {
      throw Exception('Failed to discover movies: $e');
    }
  }
}
