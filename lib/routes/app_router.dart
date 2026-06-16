import 'package:go_router/go_router.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/home/main_wrapper.dart';
import '../screens/movie_detail/movie_detail_screen.dart';
import '../screens/tv_detail/tv_detail_screen.dart';
import '../screens/tv_detail/episode_detail_screen.dart';
import '../screens/profile/favorites_screen.dart';
import '../screens/profile/watchlist_screen.dart';
import '../webview/play_webview_screen.dart';
import '../screens/home/explore_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/main',
        builder: (context, state) => const MainWrapper(),
      ),
      GoRoute(
        path: '/movie/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return MovieDetailScreen(movieId: id);
        },
      ),
      GoRoute(
        path: '/tv/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return TvDetailScreen(tvId: id);
        },
      ),
      GoRoute(
        path: '/play',
        builder: (context, state) {
          final url = state.extra as String;
          return PlayWebViewScreen(url: url);
        },
      ),
      GoRoute(
        path: '/watchlist',
        builder: (context, state) => const WatchlistScreen(),
      ),
      GoRoute(
        path: '/favorites',
        builder: (context, state) => const FavoritesScreen(),
      ),
      GoRoute(
        path: '/tv/:seriesId/season/:season/episode/:episode',
        builder: (context, state) {
          final seriesId = int.parse(state.pathParameters['seriesId']!);
          final season = int.parse(state.pathParameters['season']!);
          final episode = int.parse(state.pathParameters['episode']!);
          final seriesName = state.uri.queryParameters['name'] ?? '';
          return EpisodeDetailScreen(
            seriesId: seriesId,
            seasonNumber: season,
            episodeNumber: episode,
            seriesName: seriesName,
          );
        },
      ),
      GoRoute(
        path: '/explore',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return ExploreScreen(
            title: extra['title'] ?? 'Explore',
            type: extra['type'] ?? 'movie',
            category: extra['category'] ?? 'popular',
            genreId: extra['genreId'],
            certification: extra['certification'],
          );
        },
      ),
    ],
  );
}
