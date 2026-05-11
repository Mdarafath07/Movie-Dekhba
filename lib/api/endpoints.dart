class Endpoints {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = 'my_api_key';

  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String imageBaseUrlOriginal = 'https://image.tmdb.org/t/p/original';

  // --- MOVIES ---
  static const String trendingMovies = '$baseUrl/trending/movie/day';
  static const String popularMovies = '$baseUrl/movie/popular';
  static const String topRatedMovies = '$baseUrl/movie/top_rated';
  static const String upcomingMovies = '$baseUrl/movie/upcoming';
  static const String nowPlayingMovies = '$baseUrl/movie/now_playing';
  static const String discoverMovies = '$baseUrl/discover/movie';
  static const String movieGenres = '$baseUrl/genre/movie/list';

  static String movieDetails(int id, {String appendToResponse = ''}) {
    final append = appendToResponse.isNotEmpty ? '?append_to_response=$appendToResponse' : '';
    return '$baseUrl/movie/$id$append';
  }
  static String movieCredits(int id) => '$baseUrl/movie/$id/credits';
  static String movieVideos(int id) => '$baseUrl/movie/$id/videos';
  static String similarMovies(int id) => '$baseUrl/movie/$id/similar';
  static String movieRecommendations(int id) => '$baseUrl/movie/$id/recommendations';
  static String movieReviews(int id, {int page = 1}) => '$baseUrl/movie/$id/reviews?page=$page';
  static String movieKeywords(int id) => '$baseUrl/movie/$id/keywords';
  static String movieReleaseDates(int id) => '$baseUrl/movie/$id/release_dates';
  static String movieWatchProviders(int id) => '$baseUrl/movie/$id/watch/providers';
  static String networkDetails(int id) => '$baseUrl/network/$id';
  static String networkAlternativeNames(int id) => '$baseUrl/network/$id/alternative_names';
  static String networkImages(int id) => '$baseUrl/network/$id/images';
  static String movieAccountStates(int id, {String? sessionId, String? guestSessionId}) {
    final params = <String, String>{};
    if (sessionId != null) params['session_id'] = sessionId;
    if (guestSessionId != null) params['guest_session_id'] = guestSessionId;
    final query = params.entries.map((e) => '${e.key}=${e.value}').join('&');
    return '$baseUrl/movie/$id/account_states${query.isNotEmpty ? '?$query' : ''}';
  }
  static String movieAlternativeTitles(int id, {String? country}) {
    return '$baseUrl/movie/$id/alternative_titles${country != null ? '?country=$country' : ''}';
  }
  static String movieExternalIds(int id) => '$baseUrl/movie/$id/external_ids';
  static String movieImages(int id, {String? includeImageLanguage, String? language}) {
    final params = <String, String>{};
    if (includeImageLanguage != null) params['include_image_language'] = includeImageLanguage;
    if (language != null) params['language'] = language;
    final query = params.entries.map((e) => '${e.key}=${e.value}').join('&');
    return '$baseUrl/movie/$id/images${query.isNotEmpty ? '?$query' : ''}';
  }
  // Bulk movie changes (by date range)
  static String movieChangesList(String startDate, String endDate, int page) => '$baseUrl/movie/changes?start_date=$startDate&end_date=$endDate&page=$page';
  // Per-movie recent changes
  static String movieChanges(int movieId, {String? startDate, String? endDate, int page = 1}) {
    final params = <String, String>{'page': page.toString()};
    if (startDate != null) params['start_date'] = startDate;
    if (endDate != null) params['end_date'] = endDate;
    final query = params.entries.map((e) => '${e.key}=${e.value}').join('&');
    return '$baseUrl/movie/$movieId/changes?$query';
  }

  // --- TV SHOWS ---
  static const String trendingTv = '$baseUrl/trending/tv/day';
  static const String popularTv = '$baseUrl/tv/popular';
  static const String topRatedTv = '$baseUrl/tv/top_rated';
  static const String airingTodayTv = '$baseUrl/tv/airing_today';
  static const String onTheAirTv = '$baseUrl/tv/on_the_air';
  static const String discoverTv = '$baseUrl/discover/tv';
  static const String tvGenres = '$baseUrl/genre/tv/list';

  static String tvDetails(int id, {String? appendToResponse, String language = 'en-US'}) {
    String url = '$baseUrl/tv/$id?language=$language';
    if (appendToResponse != null) {
      url += '&append_to_response=$appendToResponse';
    }
    return url;
  }

  static String tvAccountStates(int id, {String? sessionId, String? guestSessionId}) {
    String url = '$baseUrl/tv/$id/account_states?';
    if (sessionId != null) url += 'session_id=$sessionId';
    if (guestSessionId != null) url += 'guest_session_id=$guestSessionId';
    return url;
  }

  static String tvAggregateCredits(int id, {String language = 'en-US'}) => '$baseUrl/tv/$id/aggregate_credits?language=$language';

  static String tvSeasonDetails(int seriesId, int seasonNumber, {String? appendToResponse, String language = 'en-US'}) {
    String url = '$baseUrl/tv/$seriesId/season/$seasonNumber?language=$language';
    if (appendToResponse != null) {
      url += '&append_to_response=$appendToResponse';
    }
    return url;
  }

  static String tvCredits(int id) => '$baseUrl/tv/$id/credits';
  static String tvVideos(int id) => '$baseUrl/tv/$id/videos';
  static String similarTv(int id) => '$baseUrl/tv/$id/similar';
  static String tvRecommendations(int id) => '$baseUrl/tv/$id/recommendations';
  static String tvReviews(int id) => '$baseUrl/tv/$id/reviews';
  static String tvExternalIds(int id) => '$baseUrl/tv/$id/external_ids';
  static String tvWatchProviders(int id) => '$baseUrl/tv/$id/watch/providers';

  // --- WATCH PROVIDERS ---
  static const String watchProviderRegions = '$baseUrl/watch/providers/regions';
  static String movieWatchProviderList({String? watchRegion}) => 
      '$baseUrl/watch/providers/movie${watchRegion != null ? '?watch_region=$watchRegion' : ''}';
  static String tvWatchProviderList({String? watchRegion}) => 
      '$baseUrl/watch/providers/tv${watchRegion != null ? '?watch_region=$watchRegion' : ''}';

  static String tvEpisodeDetails(int tvId, int seasonNumber, int episodeNumber, {String? appendToResponse, String language = 'en-US'}) {
    String url = '$baseUrl/tv/$tvId/season/$seasonNumber/episode/$episodeNumber?language=$language';
    if (appendToResponse != null) url += '&append_to_response=$appendToResponse';
    return url;
  }

  static String tvEpisodeAccountStates(int seriesId, int seasonNumber, int episodeNumber, {String? sessionId, String? guestSessionId}) {
    String url = '$baseUrl/tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/account_states?';
    if (sessionId != null) url += 'session_id=$sessionId';
    if (guestSessionId != null) url += '&guest_session_id=$guestSessionId';
    return url;
  }

  static String tvEpisodeCredits(int seriesId, int seasonNumber, int episodeNumber, {String language = 'en-US'}) =>
      '$baseUrl/tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/credits?language=$language';

  static String tvEpisodeExternalIds(int seriesId, int seasonNumber, int episodeNumber) =>
      '$baseUrl/tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/external_ids';

  static String tvEpisodeImages(int seriesId, int seasonNumber, int episodeNumber, {String? includeImageLanguage}) {
    String url = '$baseUrl/tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/images';
    if (includeImageLanguage != null) url += '?include_image_language=$includeImageLanguage';
    return url;
  }

  static String tvEpisodeVideos(int seriesId, int seasonNumber, int episodeNumber, {String language = 'en-US'}) =>
      '$baseUrl/tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/videos?language=$language';

  static String tvEpisodeRating(int seriesId, int seasonNumber, int episodeNumber) =>
      '$baseUrl/tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/rating';

  // --- PEOPLE ---
  static const String popularPeople = '$baseUrl/person/popular';

  static String personDetails(int id, {String appendToResponse = ''}) {
    final append = appendToResponse.isNotEmpty
        ? '?append_to_response=$appendToResponse'
        : '';
    return '$baseUrl/person/$id$append';
  }

  static String personChanges(int personId,
      {String? startDate, String? endDate, int page = 1}) {
    final params = <String, String>{'page': page.toString()};
    if (startDate != null) params['start_date'] = startDate;
    if (endDate != null) params['end_date'] = endDate;
    final query =
        params.entries.map((e) => '${e.key}=${e.value}').join('&');
    return '$baseUrl/person/$personId/changes?$query';
  }

  static const String personLatest = '$baseUrl/person/latest';

  static String personExternalIds(int id) =>
      '$baseUrl/person/$id/external_ids';
  static String personImages(int id) => '$baseUrl/person/$id/images';
  static String personMovieCredits(int id) =>
      '$baseUrl/person/$id/movie_credits';
  static String personTvCredits(int id) => '$baseUrl/person/$id/tv_credits';
  static String personCombinedCredits(int id) =>
      '$baseUrl/person/$id/combined_credits';
  static String personTaggedImages(int id, {int page = 1}) =>
      '$baseUrl/person/$id/tagged_images?page=$page';
  static String personTranslations(int id) =>
      '$baseUrl/person/$id/translations';

  // --- SEARCH ---
  static String searchMovies(String query) => '$baseUrl/search/movie?query=$query';
  static String searchTv(String query) => '$baseUrl/search/tv?query=$query';
  static String searchPerson(String query) => '$baseUrl/search/person?query=$query';
  static String searchMulti(String query) => '$baseUrl/search/multi?query=$query';
  static String searchCollection(String query) => '$baseUrl/search/collection?query=$query';
  static String searchCompany(String query) => '$baseUrl/search/company?query=$query';
  static String searchKeyword(String query) => '$baseUrl/search/keyword?query=$query';

  // --- ACCOUNT ---
  static String accountDetails(int accountId) => '$baseUrl/account/$accountId';
  static String accountFavoriteMovies(int accountId) => '$baseUrl/account/$accountId/favorite/movies';
  static String accountFavoriteTv(int accountId) => '$baseUrl/account/$accountId/favorite/tv';
  static String accountWatchlistMovies(int accountId) => '$baseUrl/account/$accountId/watchlist/movies';
  static String accountWatchlistTv(int accountId) => '$baseUrl/account/$accountId/watchlist/tv';
  static String accountLists(int accountId) => '$baseUrl/account/$accountId/lists';
  static String accountRatedMovies(int accountId) => '$baseUrl/account/$accountId/rated/movies';
  static String accountRatedTv(int accountId) => '$baseUrl/account/$accountId/rated/tv';
  static String accountRatedTvEpisodes(int accountId) => '$baseUrl/account/$accountId/rated/tv/episodes';
  static String markFavorite(int accountId) => '$baseUrl/account/$accountId/favorite';
  static String addToWatchlist(int accountId) => '$baseUrl/account/$accountId/watchlist';

  // --- OTHER ---
  static const String movieCertifications = '$baseUrl/certification/movie/list';
  static const String tvCertifications = '$baseUrl/certification/tv/list';

  // --- COLLECTIONS ---
  static String collectionDetails(int collectionId) => '$baseUrl/collection/$collectionId';
  static String collectionTranslations(int collectionId) => '$baseUrl/collection/$collectionId/translations';

  // --- COMPANIES ---
  static String companyDetails(int companyId) => '$baseUrl/company/$companyId';
  static String companyAlternativeNames(int companyId) => '$baseUrl/company/$companyId/alternative_names';
  static String companyImages(int companyId) => '$baseUrl/company/$companyId/images';

  // --- CONFIGURATION ---
  static const String configurationDetails = '$baseUrl/configuration';
  static const String configurationCountries = '$baseUrl/configuration/countries';
  static const String configurationJobs = '$baseUrl/configuration/jobs';
  static const String configurationLanguages = '$baseUrl/configuration/languages';
  static const String configurationPrimaryTranslations = '$baseUrl/configuration/primary_translations';
  static const String configurationTimezones = '$baseUrl/configuration/timezones';

  // --- FIND ---
  static String findById(String externalId, String externalSource) => '$baseUrl/find/$externalId?external_source=$externalSource';

  // --- AUTHENTICATION ---
  static const String createRequestToken = '$baseUrl/authentication/token/new';

  // --- GUEST SESSION ---
  static const String createGuestSession = '$baseUrl/authentication/guest_session/new';
  static String guestSessionRatedTv(String guestSessionId) => '$baseUrl/guest_session/$guestSessionId/rated/tv';
  static String guestSessionRatedTvEpisodes(String guestSessionId) => '$baseUrl/guest_session/$guestSessionId/rated/tv/episodes';

  // --- KEYWORDS ---
  static String keywordDetails(int keywordId) => '$baseUrl/keyword/$keywordId';
  static String keywordMovies(int keywordId) => '$baseUrl/keyword/$keywordId/movies';

  // --- LISTS ---
  static const String createList = '$baseUrl/list';
  static String listDetails(int listId) => '$baseUrl/list/$listId';
  static String deleteList(int listId) => '$baseUrl/list/$listId';
  static String listCheckItemStatus(int listId, int movieId) => '$baseUrl/list/$listId/item_status?movie_id=$movieId';
  static String removeMovieFromList(int listId) => '$baseUrl/list/$listId/remove_item';

  // --- TRENDING ---
  static String trendingAll(String timeWindow) => '$baseUrl/trending/all/$timeWindow';
  static String trendingMoviesByWindow(String timeWindow) => '$baseUrl/trending/movie/$timeWindow';
  static String trendingTvByWindow(String timeWindow) => '$baseUrl/trending/tv/$timeWindow';
  static String trendingPeople(String timeWindow) => '$baseUrl/trending/person/$timeWindow';

  // --- REVIEWS ---
  static String reviewDetails(String reviewId) => '$baseUrl/review/$reviewId';
}

