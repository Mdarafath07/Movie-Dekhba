import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/find_model.dart';
import '../repositories/find_repository.dart';

final findRepositoryProvider = Provider<FindRepository>((ref) {
  return FindRepository();
});

final findByIdProvider = FutureProvider.family<FindResponse, Map<String, String>>((ref, params) async {
  final repository = ref.watch(findRepositoryProvider);
  return repository.findById(params['externalId']!, params['externalSource']!);
});
