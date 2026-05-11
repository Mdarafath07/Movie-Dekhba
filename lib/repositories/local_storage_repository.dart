import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'firestore_repository.dart';

class LocalStorageRepository {
  String _getRecentPlaysKey(String uid) => '${uid}_recent_plays';
  String _getSearchHistoryKey(String uid) => '${uid}_search_history';

  Future<void> saveToRecentPlays(String uid, FavoriteItem item) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _getRecentPlaysKey(uid);
    final currentListJson = prefs.getStringList(key) ?? [];
    
    // Remove if already exists (to move to top)
    currentListJson.removeWhere((json) {
      final map = jsonDecode(json);
      return map['id'] == item.id && map['mediaType'] == item.mediaType;
    });

    // Add to top
    currentListJson.insert(0, jsonEncode(item.toMap()));

    // Keep only last 20
    if (currentListJson.length > 20) {
      currentListJson.removeLast();
    }

    await prefs.setStringList(key, currentListJson);
  }

  Future<List<FavoriteItem>> getRecentPlays(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _getRecentPlaysKey(uid);
    final list = prefs.getStringList(key) ?? [];
    return list.map((json) => FavoriteItem.fromMap(jsonDecode(json))).toList();
  }

  Future<void> saveToSearchHistory(String uid, String query) async {
    if (query.trim().isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    final key = _getSearchHistoryKey(uid);
    final history = prefs.getStringList(key) ?? [];
    
    history.remove(query);
    history.insert(0, query);

    if (history.length > 10) {
      history.removeLast();
    }

    await prefs.setStringList(key, history);
  }

  Future<List<String>> getSearchHistory(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _getSearchHistoryKey(uid);
    return prefs.getStringList(key) ?? [];
  }

  Future<void> clearSearchHistory(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _getSearchHistoryKey(uid);
    await prefs.remove(key);
  }
}
