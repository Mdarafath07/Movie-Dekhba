import '../../api/endpoints.dart';
import '../../models/tv_show_model.dart';
import '../../models/tv_detail_model.dart';
import '../../models/movie_misc_models.dart';
import '../../models/tv_aggregate_credits_model.dart';
import '../../models/tv_episode_detail_model.dart';
import '../../models/watch_provider_model.dart';
import '../core/network/dio_client.dart';

class TvRepository {
  final DioClient _dioClient;

  TvRepository({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  Future<TvShowResponse> getTrendingTv() async {
    try {
      final response = await _dioClient.dio.get(Endpoints.trendingTv);
      return TvShowResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load trending TV shows: $e');
    }
  }

  Future<TvShowResponse> getPopularTv({int page = 1, String language = 'en-US'}) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.popularTv,
        queryParameters: {
          'page': page,
          'language': language,
        },
      );
      return TvShowResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load popular TV shows: $e');
    }
  }

  Future<TvShowResponse> getTopRatedTv({int page = 1, String language = 'en-US'}) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.topRatedTv,
        queryParameters: {
          'page': page,
          'language': language,
        },
      );
      return TvShowResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load top rated TV shows: $e');
    }
  }

  Future<TvShowResponse> getAiringTodayTv({
    int page = 1,
    String language = 'en-US',
    String? timezone,
  }) async {
    try {
      final queryParams = {
        'page': page,
        'language': language,
      };
      if (timezone != null) queryParams['timezone'] = timezone;

      final response = await _dioClient.dio.get(
        Endpoints.airingTodayTv,
        queryParameters: queryParams,
      );
      return TvShowResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load airing today TV shows: $e');
    }
  }

  Future<TvShowResponse> getOnTheAirTv({
    int page = 1,
    String language = 'en-US',
    String? timezone,
  }) async {
    try {
      final queryParams = {
        'page': page,
        'language': language,
      };
      if (timezone != null) queryParams['timezone'] = timezone;

      final response = await _dioClient.dio.get(
        Endpoints.onTheAirTv,
        queryParameters: queryParams,
      );
      return TvShowResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load on the air TV shows: $e');
    }
  }

  Future<TvDetail> getTvDetails(int id, {String? appendToResponse, String language = 'en-US'}) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.tvDetails(id, appendToResponse: appendToResponse, language: language));
      return TvDetail.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load TV details: $e');
    }
  }

  Future<AccountState> getTvAccountStates(int id, {String? sessionId, String? guestSessionId}) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.tvAccountStates(id, sessionId: sessionId, guestSessionId: guestSessionId));
      return AccountState.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load TV account states: $e');
    }
  }

  Future<TvAggregateCreditsResponse> getTvAggregateCredits(int id, {String language = 'en-US'}) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.tvAggregateCredits(id, language: language));
      return TvAggregateCreditsResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load TV aggregate credits: $e');
    }
  }

  Future<TvSeasonDetail> getTvSeasonDetails(int seriesId, int seasonNumber, {String? appendToResponse, String language = 'en-US'}) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.tvSeasonDetails(seriesId, seasonNumber, appendToResponse: appendToResponse, language: language));
      return TvSeasonDetail.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load TV season details: $e');
    }
  }

  Future<List<TvShow>> discoverTv({int page = 1}) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.discoverTv,
        queryParameters: {
          'include_adult': 'false',
          'include_null_first_air_dates': 'false',
          'language': 'en-US',
          'page': page.toString(),
          'sort_by': 'popularity.desc',
        },
      );
      return TvShowResponse.fromJson(response.data).results;
    } catch (e) {
      throw Exception('Failed to discover TV shows: $e');
    }
  }

  Future<List<TvShow>> searchTv(String query) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.searchTv(query));
      return TvShowResponse.fromJson(response.data).results;
    } catch (e) {
      throw Exception('Failed to search TV shows: $e');
    }
  }

  Future<List<dynamic>> getTvGenres() async {
    try {
      final response = await _dioClient.dio.get(Endpoints.tvGenres);
      return response.data['genres'];
    } catch (e) {
      throw Exception('Failed to load TV genres: $e');
    }
  }

  Future<List<TvShow>> getGuestSessionRatedTv(String guestSessionId) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.guestSessionRatedTv(guestSessionId));
      return TvShowResponse.fromJson(response.data).results;
    } catch (e) {
      throw Exception('Failed to load guest session rated TV shows: $e');
    }
  }

  Future<List<dynamic>> getGuestSessionRatedTvEpisodes(String guestSessionId) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.guestSessionRatedTvEpisodes(guestSessionId));
      return response.data['results'];
    } catch (e) {
      throw Exception('Failed to load guest session rated TV episodes: $e');
    }
  }

  Future<TvEpisodeExternalIds> getTvExternalIds(int id) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.tvExternalIds(id));
      return TvEpisodeExternalIds.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load TV external IDs: $e');
    }
  }

  Future<TvEpisodeFullDetail> getTvEpisodeDetails(
    int seriesId,
    int seasonNumber,
    int episodeNumber, {
    String? appendToResponse,
    String language = 'en-US',
  }) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.tvEpisodeDetails(seriesId, seasonNumber, episodeNumber,
            appendToResponse: appendToResponse, language: language),
      );
      return TvEpisodeFullDetail.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load TV episode details: $e');
    }
  }

  Future<TvEpisodeCredits> getTvEpisodeCredits(
    int seriesId,
    int seasonNumber,
    int episodeNumber, {
    String language = 'en-US',
  }) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.tvEpisodeCredits(seriesId, seasonNumber, episodeNumber, language: language),
      );
      return TvEpisodeCredits.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load TV episode credits: $e');
    }
  }

  Future<TvEpisodeVideosResponse> getTvEpisodeVideos(
    int seriesId,
    int seasonNumber,
    int episodeNumber, {
    String language = 'en-US',
  }) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.tvEpisodeVideos(seriesId, seasonNumber, episodeNumber, language: language),
      );
      return TvEpisodeVideosResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load TV episode videos: $e');
    }
  }

  Future<TvEpisodeImages> getTvEpisodeImages(
    int seriesId,
    int seasonNumber,
    int episodeNumber,
  ) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.tvEpisodeImages(seriesId, seasonNumber, episodeNumber),
      );
      return TvEpisodeImages.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load TV episode images: $e');
    }
  }

  Future<TvEpisodeExternalIds> getTvEpisodeExternalIds(
    int seriesId,
    int seasonNumber,
    int episodeNumber,
  ) async {
    try {
      final response = await _dioClient.dio.get(
        Endpoints.tvEpisodeExternalIds(seriesId, seasonNumber, episodeNumber),
      );
      return TvEpisodeExternalIds.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load TV episode external IDs: $e');
    }
  }

  Future<bool> addEpisodeRating(
    int seriesId,
    int seasonNumber,
    int episodeNumber,
    double rating, {
    String? sessionId,
    String? guestSessionId,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (sessionId != null) queryParams['session_id'] = sessionId;
      if (guestSessionId != null) queryParams['guest_session_id'] = guestSessionId;
      await _dioClient.dio.post(
        Endpoints.tvEpisodeRating(seriesId, seasonNumber, episodeNumber),
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
        data: {'value': rating},
      );
      return true;
    } catch (e) {
      throw Exception('Failed to add TV episode rating: $e');
    }
  }

  Future<bool> deleteEpisodeRating(
    int seriesId,
    int seasonNumber,
    int episodeNumber, {
    String? sessionId,
    String? guestSessionId,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (sessionId != null) queryParams['session_id'] = sessionId;
      if (guestSessionId != null) queryParams['guest_session_id'] = guestSessionId;
      await _dioClient.dio.delete(
        Endpoints.tvEpisodeRating(seriesId, seasonNumber, episodeNumber),
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );
      return true;
    } catch (e) {
      throw Exception('Failed to delete TV episode rating: $e');
    }
  }

  Future<WatchProvidersResponse> getWatchProviders(int tvId) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.tvWatchProviders(tvId));
      return WatchProvidersResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load TV watch providers: $e');
    }
  }
}
