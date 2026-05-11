import '../../api/endpoints.dart';
import '../../models/watch_provider_model.dart';
import '../core/network/dio_client.dart';

class WatchProviderRepository {
  final DioClient _dioClient;

  WatchProviderRepository({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  Future<List<TmdbRegion>> getAvailableRegions() async {
    try {
      final response = await _dioClient.dio.get(Endpoints.watchProviderRegions);
      return TmdbRegionResponse.fromJson(response.data).results;
    } catch (e) {
      throw Exception('Failed to load available regions: $e');
    }
  }

  Future<List<WatchProviderItem>> getMovieWatchProviders({String? watchRegion}) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.movieWatchProviderList(watchRegion: watchRegion));
      return TmdbProviderResponse.fromJson(response.data).results;
    } catch (e) {
      throw Exception('Failed to load movie watch providers: $e');
    }
  }

  Future<List<WatchProviderItem>> getTvWatchProviders({String? watchRegion}) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.tvWatchProviderList(watchRegion: watchRegion));
      return TmdbProviderResponse.fromJson(response.data).results;
    } catch (e) {
      throw Exception('Failed to load TV watch providers: $e');
    }
  }
}
