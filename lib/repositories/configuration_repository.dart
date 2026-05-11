import 'package:dio/dio.dart';
import '../../api/endpoints.dart';
import '../../models/configuration_model.dart';
import '../core/network/dio_client.dart';

class ConfigurationRepository {
  final DioClient _dioClient;

  ConfigurationRepository({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  Future<ApiConfiguration> getApiConfiguration() async {
    try {
      final response = await _dioClient.dio.get(Endpoints.configurationDetails);
      return ApiConfiguration.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load api configuration: $e');
    }
  }

  Future<List<Country>> getCountries() async {
    try {
      final response = await _dioClient.dio.get(Endpoints.configurationCountries);
      final List<dynamic> data = response.data;
      return data.map((json) => Country.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load countries configuration: $e');
    }
  }

  Future<List<JobDepartment>> getJobs() async {
    try {
      final response = await _dioClient.dio.get(Endpoints.configurationJobs);
      final List<dynamic> data = response.data;
      return data.map((json) => JobDepartment.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load jobs configuration: $e');
    }
  }

  Future<List<Language>> getLanguages() async {
    try {
      final response = await _dioClient.dio.get(Endpoints.configurationLanguages);
      final List<dynamic> data = response.data;
      return data.map((json) => Language.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load languages configuration: $e');
    }
  }

  Future<List<String>> getPrimaryTranslations() async {
    try {
      final response = await _dioClient.dio.get(Endpoints.configurationPrimaryTranslations);
      final List<dynamic> data = response.data;
      return data.map((item) => item.toString()).toList();
    } catch (e) {
      throw Exception('Failed to load primary translations configuration: $e');
    }
  }

  Future<List<Timezone>> getTimezones() async {
    try {
      final response = await _dioClient.dio.get(Endpoints.configurationTimezones);
      final List<dynamic> data = response.data;
      return data.map((json) => Timezone.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load timezones configuration: $e');
    }
  }
}
