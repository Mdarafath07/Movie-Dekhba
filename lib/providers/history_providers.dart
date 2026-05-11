import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/local_storage_repository.dart';
import '../repositories/firestore_repository.dart';
import '../providers/auth_providers.dart';

final localStorageRepositoryProvider = Provider((ref) => LocalStorageRepository());

final recentPlaysProvider = StateNotifierProvider<RecentPlaysNotifier, List<FavoriteItem>>((ref) {
  final user = ref.watch(userProvider);
  return RecentPlaysNotifier(ref.watch(localStorageRepositoryProvider), user?.uid);
});

class RecentPlaysNotifier extends StateNotifier<List<FavoriteItem>> {
  final LocalStorageRepository _repository;
  final String? _uid;

  RecentPlaysNotifier(this._repository, this._uid) : super([]) {
    load();
  }

  Future<void> load() async {
    if (_uid == null) {
      state = [];
      return;
    }
    state = await _repository.getRecentPlays(_uid!);
  }

  Future<void> addToRecent(FavoriteItem item) async {
    if (_uid == null) return;
    await _repository.saveToRecentPlays(_uid!, item);
    await load();
  }
}

final searchHistoryProvider = StateNotifierProvider<SearchHistoryNotifier, List<String>>((ref) {
  final user = ref.watch(userProvider);
  return SearchHistoryNotifier(ref.watch(localStorageRepositoryProvider), user?.uid);
});

class SearchHistoryNotifier extends StateNotifier<List<String>> {
  final LocalStorageRepository _repository;
  final String? _uid;

  SearchHistoryNotifier(this._repository, this._uid) : super([]) {
    load();
  }

  Future<void> load() async {
    if (_uid == null) {
      state = [];
      return;
    }
    state = await _repository.getSearchHistory(_uid!);
  }

  Future<void> addQuery(String query) async {
    if (_uid == null) return;
    await _repository.saveToSearchHistory(_uid!, query);
    await load();
  }

  Future<void> clear() async {
    if (_uid == null) return;
    await _repository.clearSearchHistory(_uid!);
    state = [];
  }
}
