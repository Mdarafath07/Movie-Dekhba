import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/account_repository.dart';

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  return AccountRepository();
});
