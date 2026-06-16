import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/search_providers.dart';
import '../../providers/find_providers.dart';
import '../../widgets/movie_poster.dart';
import '../../providers/history_providers.dart';
import '../../core/utils/responsive_utils.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _externalIdController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String _selectedSource = 'imdb_id';

  get _sources => null;
  
  @override
  void initState() {
    super.initState();
    // Sync controller with provider initial state if any
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchController.text = ref.read(searchTextProvider);
    });
  }

  @override
  void dispose() {
    _externalIdController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showFindByIdSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 24,
                left: 16,
                right: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Find by External ID', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedSource,
                    dropdownColor: Colors.grey[850],
                    decoration: const InputDecoration(labelText: 'External Source', border: OutlineInputBorder()),
                    items: _sources.map((source) => DropdownMenuItem(value: source, child: Text(source))).toList(),
                    onChanged: (val) {
                      if (val != null) setSheetState(() => _selectedSource = val);
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _externalIdController,
                    decoration: const InputDecoration(labelText: 'External ID', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _executeFindById();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red, padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: const Text('Search'),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          }
        );
      }
    );
  }

  void _executeFindById() async {
    final externalId = _externalIdController.text.trim();
    if (externalId.isEmpty) return;

    showDialog(context: context, barrierDismissible: false, builder: (_) => const Center(child: CircularProgressIndicator()));
    try {
      final response = await ref.read(findRepositoryProvider).findById(externalId, _selectedSource);
      if (mounted) Navigator.pop(context); // close dialog

      if (response.movieResults.isNotEmpty) {
        if (mounted) context.push('/movie/${response.movieResults.first.id}');
      } else if (response.tvResults.isNotEmpty) {
         // Would push to TV show detail if we had it, fallback to snackbar
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Found TV Show: ${response.tvResults.first.name}')));
      } else if (response.personResults.isNotEmpty) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Found Person: ${response.personResults.first.name}')));
      } else {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No matching content found.')));
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchAsyncValue = ref.watch(searchMultiProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search movies, TV shows...',
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, color: Colors.grey),
              onPressed: () {
                _searchController.clear();
                ref.read(searchTextProvider.notifier).state = '';
              },
            ),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 18),
          onChanged: (value) {
            ref.read(searchTextProvider.notifier).state = value;
          },
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              ref.read(searchHistoryProvider.notifier).addQuery(value);
            }
          },
        ),

      ),
      body: searchAsyncValue.when(
        data: (response) {
          final results = response.results;
           if (results.isEmpty && ref.watch(searchTextProvider).isNotEmpty) {
            return const Center(child: Text('No results found.'));
          }
          if (results.isEmpty) {
            final history = ref.watch(searchHistoryProvider);
            if (history.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_rounded, size: 64, color: Colors.white10),
                    SizedBox(height: 16),
                    Text('Search for movies, TV shows...', style: TextStyle(color: Colors.white54, fontSize: 16)),
                  ],
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('RECENT SEARCHES', style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                      TextButton(
                        onPressed: () => ref.read(searchHistoryProvider.notifier).clear(),
                        child: const Text('Clear', style: TextStyle(color: Colors.red, fontSize: 12)),
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 8,
                    children: history.map((query) => ActionChip(
                      label: Text(query, style: const TextStyle(fontSize: 13)),
                      backgroundColor: Colors.white.withOpacity(0.05),
                      side: BorderSide(color: Colors.white.withOpacity(0.1)),
                      onPressed: () {
                        _searchController.text = query;
                        _searchController.selection = TextSelection.fromPosition(TextPosition(offset: query.length));
                        ref.read(searchTextProvider.notifier).state = query;
                        ref.read(searchHistoryProvider.notifier).addQuery(query);
                      },
                    )).toList(),
                  ),
                ],
              ),
            );
          }

          return Responsive.constrainedContent(
            context: context,
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.gridColumns(context),
                childAspectRatio: Responsive.gridAspectRatio(context),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final item = results[index];
                return MoviePoster(
                  posterPath: item.displayImagePath,
                  width: double.infinity,
                  height: double.infinity,
                  onTap: () {
                    if (item.mediaType == 'movie') {
                      context.push('/movie/${item.id}');
                    } else if (item.mediaType == 'tv') {
                      context.push('/tv/${item.id}');
                    }
                  },
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

