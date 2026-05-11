class PlayUrlHelper {
  static String getPlayUrl({
    String? imdbId,
    int? tmdbId,
    int? season,
    int? episode,
  }) {
    final bool isTv = season != null && episode != null;
    final String mId = imdbId ?? tmdbId?.toString() ?? '';

    if (isTv) {
      // Default to playimdb path-based format
      return 'https://www.playimdb.com/title/$mId/season/$season/episode/$episode/';
    }
    return 'https://www.playimdb.com/title/$mId/';
  }
}
