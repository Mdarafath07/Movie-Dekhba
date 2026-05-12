/// Represents a single playback server / audio language option.
class PlayServer {
  final String label;
  final String emoji;
  final String url;

  const PlayServer({
    required this.label,
    required this.emoji,
    required this.url,
  });
}

class PlayUrlHelper {
  // ── Movie servers ──────────────────────────────────────────────────────────
  static List<PlayServer> getMovieServers({
    String? imdbId,
    required int tmdbId,
  }) {
    final id = imdbId ?? tmdbId.toString();
    return [
      PlayServer(
        label: 'English',
        emoji: '🇬🇧',
        url: 'https://www.playimdb.com/title/$id/',
      ),
      PlayServer(
        label: 'Hindi',
        emoji: '🇮🇳',
        url: 'https://vidsrc.xyz/embed/movie?tmdb=$tmdbId',
      ),
      PlayServer(
        label: 'Multi',
        emoji: '🌐',
        url: imdbId != null
            ? 'https://multiembed.mov/directstream.php?video_id=$imdbId&tmdb=1'
            : 'https://multiembed.mov/directstream.php?video_id=$tmdbId&tmdb=1',
      ),
      PlayServer(
        label: 'Server 2',
        emoji: '🔄',
        url: 'https://embed.su/embed/movie/$tmdbId',
      ),
      PlayServer(
        label: 'Server 3',
        emoji: '⚡',
        url: 'https://vidsrc.pro/embed/movie/$tmdbId',
      ),
    ];
  }

  // ── TV / Episode servers ───────────────────────────────────────────────────
  static List<PlayServer> getTvServers({
    String? imdbId,
    required int tmdbId,
    required int season,
    required int episode,
  }) {
    final id = imdbId ?? tmdbId.toString();
    return [
      PlayServer(
        label: 'English',
        emoji: '🇬🇧',
        url: 'https://www.playimdb.com/title/$id/season/$season/episode/$episode/',
      ),
      PlayServer(
        label: 'Hindi',
        emoji: '🇮🇳',
        url: 'https://vidsrc.xyz/embed/tv?tmdb=$tmdbId&season=$season&episode=$episode',
      ),
      PlayServer(
        label: 'Multi',
        emoji: '🌐',
        url: imdbId != null
            ? 'https://multiembed.mov/directstream.php?video_id=$imdbId&tmdb=1&s=$season&e=$episode'
            : 'https://multiembed.mov/directstream.php?video_id=$tmdbId&tmdb=1&s=$season&e=$episode',
      ),
      PlayServer(
        label: 'Server 2',
        emoji: '🔄',
        url: 'https://embed.su/embed/tv/$tmdbId/$season/$episode',
      ),
      PlayServer(
        label: 'Server 3',
        emoji: '⚡',
        url: 'https://vidsrc.pro/embed/tv/$tmdbId/$season/$episode',
      ),
    ];
  }

  // ── Legacy single-URL helper (kept for backward compat) ───────────────────
  static String getPlayUrl({
    String? imdbId,
    int? tmdbId,
    int? season,
    int? episode,
  }) {
    final bool isTv = season != null && episode != null;
    final String mId = imdbId ?? tmdbId?.toString() ?? '';
    if (isTv) {
      return 'https://www.playimdb.com/title/$mId/season/$season/episode/$episode/';
    }
    return 'https://www.playimdb.com/title/$mId/';
  }
}

