import 'package:dio/dio.dart';
import '../../api/endpoints.dart';
import '../../models/company_model.dart';
import '../core/network/dio_client.dart';

class CompanyRepository {
  final DioClient _dioClient;

  CompanyRepository({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  Future<CompanyDetail> getCompanyDetails(int companyId) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.companyDetails(companyId));
      return CompanyDetail.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load company details: $e');
    }
  }

  Future<List<CompanyAlternativeName>> getCompanyAlternativeNames(int companyId) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.companyAlternativeNames(companyId));
      return CompanyAlternativeNamesResponse.fromJson(response.data).results;
    } catch (e) {
      throw Exception('Failed to load company alternative names: $e');
    }
  }

  Future<List<CompanyLogo>> getCompanyImages(int companyId) async {
    try {
      final response = await _dioClient.dio.get(Endpoints.companyImages(companyId));
      return CompanyImagesResponse.fromJson(response.data).logos;
    } catch (e) {
      throw Exception('Failed to load company images: $e');
    }
  }
}
