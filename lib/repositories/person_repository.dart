import 'package:dio/dio.dart';
import '../api/endpoints.dart';
import '../models/change_model.dart';
import '../models/person_model.dart';
import '../models/person_detail_model.dart';
import '../models/person_combined_credits_model.dart';
import '../models/person_external_ids_model.dart';
import '../models/person_images_model.dart';
import '../models/person_movie_credits_model.dart';
import '../models/person_tv_credits_model.dart';
import '../models/person_tagged_images_model.dart';
import '../models/person_translations_model.dart';
import '../core/network/dio_client.dart';

class PersonRepository {
  final DioClient _dioClient;

  PersonRepository({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  // ---------------------------------------------------------------------------
  // Popular people
  // ---------------------------------------------------------------------------

  /// Returns just the results list (page 1) — used by simple widgets.
  Future<List<Person>> getPopularPeople({int page = 1}) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.popularPeople,
        queryParameters: {'page': page},
      );
      return PersonResponse.fromJson(response.data).results;
    } on DioException catch (e) {
      throw Exception('Failed to load popular people: ${e.message}');
    }
  }

  /// Returns the full paginated response (page + total info).
  Future<PersonResponse> getPopularPeoplePaged({int page = 1}) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.popularPeople,
        queryParameters: {'page': page},
      );
      return PersonResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load popular people: ${e.message}');
    }
  }

  // ---------------------------------------------------------------------------
  // Latest person  — GET /3/person/latest
  // ---------------------------------------------------------------------------

  /// Returns the most recently created person record.
  /// This is a live response and will continuously change.
  Future<PersonDetail> getLatestPerson() async {
    try {
      final response = await _dioClient.dio.get(Endpoints.personLatest);
      return PersonDetail.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load latest person: ${e.message}');
    }
  }

  // ---------------------------------------------------------------------------
  // Person details  — GET /3/person/{person_id}
  // ---------------------------------------------------------------------------

  /// Fetches full details for a single person.
  ///
  /// Pass [appendToResponse] as a comma-separated string to request
  /// additional sub-resources in one round-trip, e.g.
  /// `"combined_credits,external_ids"`.
  Future<PersonDetail> getPersonDetails(
    int personId, {
    String appendToResponse = '',
    String language = 'en-US',
  }) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.personDetails(personId,
            appendToResponse: appendToResponse),
        queryParameters: {'language': language},
      );
      return PersonDetail.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load person details: ${e.message}');
    }
  }

  // ---------------------------------------------------------------------------
  // Person changes  — GET /3/person/{person_id}/changes
  // ---------------------------------------------------------------------------

  /// Returns recent changes for the person.
  ///
  /// By default returns the last 24 hours.
  /// You can query up to 14 days by providing [startDate] / [endDate]
  /// in `YYYY-MM-DD` format.
  Future<ChangesResponse> getPersonChanges(
    int personId, {
    String? startDate,
    String? endDate,
    int page = 1,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.personChanges(personId,
            startDate: startDate, endDate: endDate, page: page),
      );
      return ChangesResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load person changes: ${e.message}');
    }
  }

  // ---------------------------------------------------------------------------
  // External IDs  — GET /3/person/{person_id}/external_ids
  // ---------------------------------------------------------------------------

  /// Returns all external IDs for a person
  /// (IMDb, Wikidata, Facebook, Instagram, TikTok, Twitter, YouTube, etc.).
  Future<PersonExternalIds> getPersonExternalIds(int personId) async {
    try {
      final response =
          await _dioClient.dio.get(Endpoints.personExternalIds(personId));
      return PersonExternalIds.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load person external IDs: ${e.message}');
    }
  }

  // ---------------------------------------------------------------------------
  // Images  — GET /3/person/{person_id}/images
  // ---------------------------------------------------------------------------

  /// Returns all profile images that have been added to a person.
  Future<PersonImages> getPersonImages(int personId) async {
    try {
      final response =
          await _dioClient.dio.get(Endpoints.personImages(personId));
      return PersonImages.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load person images: ${e.message}');
    }
  }

  // ---------------------------------------------------------------------------
  // Movie credits  — GET /3/person/{person_id}/movie_credits
  // ---------------------------------------------------------------------------

  /// Returns the movie credits (cast and crew) for a person.
  Future<PersonMovieCreditsResponse> getPersonMovieCredits(
    int personId, {
    String language = 'en-US',
  }) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.personMovieCredits(personId),
        queryParameters: {'language': language},
      );
      return PersonMovieCreditsResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load person movie credits: ${e.message}');
    }
  }

  // ---------------------------------------------------------------------------
  // Combined credits  — GET /3/person/{person_id}/combined_credits
  // ---------------------------------------------------------------------------

  /// Returns the combined movie + TV credits (cast and crew) for a person.
  Future<CombinedCreditsResponse> getCombinedCredits(
    int personId, {
    String language = 'en-US',
  }) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.personCombinedCredits(personId),
        queryParameters: {'language': language},
      );
      return CombinedCreditsResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load combined credits: ${e.message}');
    }
  }

  // ---------------------------------------------------------------------------
  // TV credits  — GET /3/person/{person_id}/tv_credits
  // ---------------------------------------------------------------------------

  /// Returns the TV credits (cast and crew) for a person.
  Future<PersonTvCreditsResponse> getPersonTvCredits(
    int personId, {
    String language = 'en-US',
  }) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.personTvCredits(personId),
        queryParameters: {'language': language},
      );
      return PersonTvCreditsResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load person TV credits: ${e.message}');
    }
  }

  // ---------------------------------------------------------------------------
  // Tagged images  — GET /3/person/{person_id}/tagged_images
  // ---------------------------------------------------------------------------

  /// Returns the tagged images for a person (paginated).
  Future<PersonTaggedImagesResponse> getPersonTaggedImages(
    int personId, {
    int page = 1,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.personTaggedImages(personId, page: page),
      );
      return PersonTaggedImagesResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load person tagged images: ${e.message}');
    }
  }

  // ---------------------------------------------------------------------------
  // Translations  — GET /3/person/{person_id}/translations
  // ---------------------------------------------------------------------------

  /// Returns all available translations for a person's biography and name.
  Future<PersonTranslationsResponse> getPersonTranslations(int personId) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.personTranslations(personId),
      );
      return PersonTranslationsResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to load person translations: ${e.message}');
    }
  }

  // ---------------------------------------------------------------------------
  // Search
  // ---------------------------------------------------------------------------

  Future<List<Person>> searchPerson(String query, {int page = 1}) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.searchPerson(query),
        queryParameters: {'page': page},
      );
      return PersonResponse.fromJson(response.data).results;
    } on DioException catch (e) {
      throw Exception('Failed to search people: ${e.message}');
    }
  }
}
