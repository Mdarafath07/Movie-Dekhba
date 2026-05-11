import 'package:dio/dio.dart';
import '../api/endpoints.dart';
import '../core/network/dio_client.dart';
import '../models/collection_model.dart';
import '../models/company_model.dart';
import '../models/keyword_model.dart';
import '../models/movie_response.dart';
import '../models/person_model.dart';
import '../models/search_multi_model.dart';
import '../models/tv_show_model.dart';

/// Repository that covers all seven TMDB /search/* endpoints.
class SearchRepository {
  final DioClient _dioClient;

  SearchRepository({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  // ---------------------------------------------------------------------------
  // Collection  — GET /3/search/collection
  // ---------------------------------------------------------------------------
  Future<SearchCollectionResponse> searchCollections(
    String query, {
    int page = 1,
    bool includeAdult = false,
    String language = 'en-US',
    String? region,
  }) async {
    try {
      final params = <String, dynamic>{
        'page': page,
        'include_adult': includeAdult,
        'language': language,
      };
      if (region != null) params['region'] = region;

      final response = await _dioClient.dio.get(
        Endpoints.searchCollection(query),
        queryParameters: params,
      );
      return SearchCollectionResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to search collections: ${e.message}');
    }
  }

  // ---------------------------------------------------------------------------
  // Company  — GET /3/search/company
  // ---------------------------------------------------------------------------
  Future<SearchCompanyResponse> searchCompanies(
    String query, {
    int page = 1,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.searchCompany(query),
        queryParameters: {'page': page},
      );
      return SearchCompanyResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to search companies: ${e.message}');
    }
  }

  // ---------------------------------------------------------------------------
  // Keyword  — GET /3/search/keyword
  // ---------------------------------------------------------------------------
  Future<SearchKeywordResponse> searchKeywords(
    String query, {
    int page = 1,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.searchKeyword(query),
        queryParameters: {'page': page},
      );
      return SearchKeywordResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to search keywords: ${e.message}');
    }
  }

  // ---------------------------------------------------------------------------
  // Movie  — GET /3/search/movie
  // ---------------------------------------------------------------------------
  Future<MovieResponse> searchMovies(
    String query, {
    int page = 1,
    bool includeAdult = false,
    String language = 'en-US',
    String? primaryReleaseYear,
    String? region,
    String? year,
  }) async {
    try {
      final params = <String, dynamic>{
        'page': page,
        'include_adult': includeAdult,
        'language': language,
      };
      if (primaryReleaseYear != null) {
        params['primary_release_year'] = primaryReleaseYear;
      }
      if (region != null) params['region'] = region;
      if (year != null) params['year'] = year;

      final response = await _dioClient.dio.get(
        Endpoints.searchMovies(query),
        queryParameters: params,
      );
      return MovieResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to search movies: ${e.message}');
    }
  }

  // ---------------------------------------------------------------------------
  // Multi  — GET /3/search/multi
  // ---------------------------------------------------------------------------
  Future<MultiSearchResponse> searchMulti(
    String query, {
    int page = 1,
    bool includeAdult = false,
    String language = 'en-US',
  }) async {
    try {
      final params = <String, dynamic>{
        'page': page,
        'include_adult': includeAdult,
        'language': language,
      };
      final response = await _dioClient.dio.get(
        Endpoints.searchMulti(query),
        queryParameters: params,
      );
      return MultiSearchResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to multi-search: ${e.message}');
    }
  }

  // ---------------------------------------------------------------------------
  // Person  — GET /3/search/person
  // ---------------------------------------------------------------------------
  Future<PersonResponse> searchPeople(
    String query, {
    int page = 1,
    bool includeAdult = false,
    String language = 'en-US',
  }) async {
    try {
      final params = <String, dynamic>{
        'page': page,
        'include_adult': includeAdult,
        'language': language,
      };
      final response = await _dioClient.dio.get(
        Endpoints.searchPerson(query),
        queryParameters: params,
      );
      return PersonResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to search people: ${e.message}');
    }
  }

  // ---------------------------------------------------------------------------
  // TV  — GET /3/search/tv
  // ---------------------------------------------------------------------------
  Future<TvShowResponse> searchTv(
    String query, {
    int page = 1,
    bool includeAdult = false,
    String language = 'en-US',
    int? firstAirDateYear,
    int? year,
  }) async {
    try {
      final params = <String, dynamic>{
        'page': page,
        'include_adult': includeAdult,
        'language': language,
      };
      if (firstAirDateYear != null) {
        params['first_air_date_year'] = firstAirDateYear;
      }
      if (year != null) params['year'] = year;

      final response = await _dioClient.dio.get(
        Endpoints.searchTv(query),
        queryParameters: params,
      );
      return TvShowResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to search TV shows: ${e.message}');
    }
  }
}
