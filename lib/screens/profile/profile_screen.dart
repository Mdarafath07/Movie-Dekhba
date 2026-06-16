import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/auth_providers.dart';
import '../../providers/theme_provider.dart';
import '../../providers/history_providers.dart';
import '../../api/endpoints.dart';
import '../../providers/user_content_providers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/services/email_service.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final themeMode = ref.watch(themeProvider);
    final recentPlays = ref.watch(recentPlaysProvider);
    final favorites = ref.watch(favoritesStreamProvider).valueOrNull ?? [];
    final watchlist = ref.watch(watchlistStreamProvider).valueOrNull ?? [];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF0D0F14) : const Color(0xFFF5F6FA);
    final cardColor = isDark ? const Color(0xFF1C2230) : const Color(0xFFFFFFFF);
    final textPrimary = isDark ? const Color(0xFFF0F2F5) : const Color(0xFF0D1117);
    final textSecondary = isDark ? const Color(0xFF8B95A8) : const Color(0xFF4A5568);
    final dividerColor = isDark ? const Color(0xFF2A3142) : const Color(0xFFE2E8F0);

    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Hero Header ──────────────────────────────────
          SliverToBoxAdapter(
            child: Stack(
              children: [
                // Gradient background
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDark
                          ? [const Color(0xFF1A0A0A), const Color(0xFF200B0B), const Color(0xFF161B22)]
                          : [const Color(0xFFFFE5E5), const Color(0xFFFFF0F0), const Color(0xFFF5F6FA)],
                    ),
                  ),
                ),
                // Decorative circle
                Positioned(
                  top: -40,
                  right: -40,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFE50914).withOpacity(isDark ? 0.06 : 0.08),
                    ),
                  ),
                ),
                // Profile content
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 52, bottom: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar
                        Stack(
                          children: [
                            Container(
                              width: 88,
                              height: 88,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFE50914), Color(0xFF8B0000)],
                                ),
                                border: Border.all(
                                  color: const Color(0xFFE50914).withOpacity(0.5),
                                  width: 2.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFE50914).withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: user?.photoURL != null
                                    ? Image.network(user!.photoURL!, fit: BoxFit.cover)
                                    : Icon(Icons.person_rounded, size: 48, color: Colors.white.withOpacity(0.9)),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: isDark ? const Color(0xFF1C2230) : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: const Color(0xFFE50914), width: 1.5),
                                ),
                                child: const Icon(Icons.edit_rounded, size: 13, color: Color(0xFFE50914)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Name
                        Text(
                          user?.displayName ?? user?.email?.split('@')[0] ?? 'Guest User',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: textPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),
                        // Email
                        Text(
                          user?.email ?? 'Not signed in',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: textSecondary,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Welcome badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE50914).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFE50914).withOpacity(0.25)),
                          ),
                          child: Text(
                            'Welcome to Movie Dekhba',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFE50914),
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Stats Row ────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _StatCard(
                    icon: Icons.favorite_rounded,
                    label: 'Favorites',
                    value: favorites.length.toString(),
                    color: const Color(0xFFE50914),
                    cardColor: cardColor,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                    onTap: () => context.push('/favorites'),
                  ),
                  const SizedBox(width: 10),
                  _StatCard(
                    icon: Icons.bookmark_rounded,
                    label: 'Watchlist',
                    value: watchlist.length.toString(),
                    color: const Color(0xFFF59E0B),
                    cardColor: cardColor,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                    onTap: () => context.push('/watchlist'),
                  ),
                  const SizedBox(width: 10),
                  _StatCard(
                    icon: Icons.history_rounded,
                    label: 'Watched',
                    value: recentPlays.length.toString(),
                    color: const Color(0xFF10B981),
                    cardColor: cardColor,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          // ── Recently Watched ─────────────────────────────
          if (recentPlays.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: _SectionLabel(text: 'Continue Watching', textColor: textSecondary),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: recentPlays.length,
                  itemBuilder: (context, index) {
                    final item = recentPlays[index];
                    return GestureDetector(
                      onTap: () => context.push('/${item.mediaType}/${item.id}'),
                      child: Container(
                        width: 110,
                        margin: const EdgeInsets.only(right: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: '${Endpoints.imageBaseUrl}${item.posterPath}',
                                  fit: BoxFit.cover,
                                  placeholder: (_, __) => Container(
                                    color: isDark ? const Color(0xFF1C2230) : const Color(0xFFE2E8F0),
                                  ),
                                  errorWidget: (_, __, ___) => Container(
                                    color: isDark ? const Color(0xFF1C2230) : const Color(0xFFE2E8F0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              item.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],

          // ── My Content ────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionLabel(text: 'Library', textColor: textSecondary),
                  const SizedBox(height: 10),
                  _ProfileTile(
                    icon: Icons.favorite_rounded,
                    iconColor: const Color(0xFFE50914),
                    title: 'My Favorites',
                    subtitle: 'Movies and shows you love',
                    cardColor: cardColor,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                    dividerColor: dividerColor,
                    onTap: () => context.push('/favorites'),
                  ),
                  _ProfileTile(
                    icon: Icons.bookmark_rounded,
                    iconColor: const Color(0xFFF59E0B),
                    title: 'My Watchlist',
                    subtitle: 'Saved for later',
                    cardColor: cardColor,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                    dividerColor: dividerColor,
                    onTap: () => context.push('/watchlist'),
                  ),

                  const SizedBox(height: 24),
                  _SectionLabel(text: 'Settings', textColor: textSecondary),
                  const SizedBox(height: 10),

                  // Dark Mode toggle
                  _ProfileTile(
                    icon: themeMode == ThemeMode.dark
                        ? Icons.dark_mode_rounded
                        : Icons.light_mode_rounded,
                    iconColor: const Color(0xFFF5A623),
                    title: 'Dark Mode',
                    subtitle: themeMode == ThemeMode.dark ? 'Switch to Light' : 'Switch to Dark',
                    cardColor: cardColor,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                    dividerColor: dividerColor,
                    trailing: Switch(
                      value: themeMode == ThemeMode.dark,
                      onChanged: (_) => ref.read(themeProvider.notifier).toggleTheme(),
                      activeColor: const Color(0xFFE50914),
                      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                    ),
                    onTap: () => ref.read(themeProvider.notifier).toggleTheme(),
                  ),

                  // Bug / Feature Report
                  _ProfileTile(
                    icon: Icons.bug_report_outlined,
                    iconColor: const Color(0xFF06B6D4),
                    title: 'Bug / Feature Report',
                    subtitle: 'Help us improve the app',
                    cardColor: cardColor,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                    dividerColor: dividerColor,
                    onTap: () => _showFeedbackDialog(context, isDark, textPrimary, textSecondary, cardColor, ref),
                  ),

                  const SizedBox(height: 28),

                  // Sign Out
                  GestureDetector(
                    onTap: () async {
                      await ref.read(authNotifierProvider.notifier).signOut();
                      if (context.mounted) context.go('/login');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE50914).withOpacity(0.07),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFE50914).withOpacity(0.25),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout_rounded, color: Color(0xFFE50914), size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Sign Out',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFE50914),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Footer
                  Center(
                    child: Column(
                      children: [


                        Text(
                          'Movie Dekhba v1.0.2',
                          style: GoogleFonts.poppins(
                            color: textSecondary.withOpacity(0.5),
                            fontSize: 10.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFeedbackDialog(BuildContext context, bool isDark, Color textPrimary, Color textSecondary, Color cardColor, WidgetRef ref) {
    final user = ref.read(userProvider);
    final msgController = TextEditingController();
    final emailController = TextEditingController(text: user?.email ?? '');
    String selectedType = 'Bug Report';
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setInnerState) => AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1C2230) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF06B6D4).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.bug_report_outlined, color: Color(0xFF06B6D4), size: 22),
              ),
              const SizedBox(width: 14),
              Text(
                'Feedback',
                style: GoogleFonts.poppins(
                  color: textPrimary,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your feedback helps us make the app better!',
                  style: GoogleFonts.poppins(
                    color: textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 20),
                // Type selector
                Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: ['Bug Report', 'Feature Request', 'Other'].map((type) {
                    final isSelected = selectedType == type;
                    return GestureDetector(
                      onTap: () => setInnerState(() => selectedType = type),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFE50914).withOpacity(0.12)
                              : (isDark ? const Color(0xFF2A3142) : const Color(0xFFF0F2F7)),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? const Color(0xFFE50914) : Colors.transparent,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          type,
                          style: GoogleFonts.poppins(
                            color: isSelected ? const Color(0xFFE50914) : textSecondary,
                            fontSize: 12.5,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                // Email field
                TextField(
                  controller: emailController,
                  style: GoogleFonts.poppins(color: textPrimary, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Your email address',
                    hintStyle: GoogleFonts.poppins(color: textSecondary.withOpacity(0.5), fontSize: 13),
                    filled: true,
                    fillColor: isDark ? const Color(0xFF0D0F14) : const Color(0xFFF5F6FA),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    prefixIcon: Icon(Icons.email_outlined, color: textSecondary.withOpacity(0.5), size: 20),
                  ),
                ),
                const SizedBox(height: 12),
                // Message
                TextField(
                  controller: msgController,
                  maxLines: 4,
                  style: GoogleFonts.poppins(color: textPrimary, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Describe your issue or suggestion...',
                    hintStyle: GoogleFonts.poppins(color: textSecondary.withOpacity(0.5), fontSize: 13),
                    filled: true,
                    fillColor: isDark ? const Color(0xFF0D0F14) : const Color(0xFFF5F6FA),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  color: textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
             StatefulBuilder(
               builder: (context, setBtnState) {
                 return ElevatedButton(
                   onPressed: isLoading ? null : () async {
                     final msg = msgController.text.trim();
                     final email = emailController.text.trim();
                     if (msg.isEmpty || email.isEmpty) return;
                     
                     setBtnState(() => isLoading = true);
                     
                     final success = await EmailService().sendFeedback(
                       userEmail: email,
                       message: msg,
                       type: selectedType,
                     );
                     
                     if (context.mounted) {
                       Navigator.pop(ctx);
                       ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                           content: Text(success ? 'Feedback sent successfully!' : 'Failed to send feedback'),
                           backgroundColor: success ? Colors.green : const Color(0xFFE50914),
                         ),
                       );
                     }
                   },
                   style: ElevatedButton.styleFrom(
                     backgroundColor: const Color(0xFFE50914),
                     foregroundColor: Colors.white,
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                     elevation: 0,
                   ),
                   child: isLoading 
                     ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                     : Text(
                         'Send Report',
                         style: GoogleFonts.poppins(
                           fontWeight: FontWeight.w700,
                           fontSize: 14,
                         ),
                       ),
                 );
               },
             ),
          ],
        ),
      ),
    );
  }
}

// ── Stat Card ──────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final Color cardColor;
  final Color textPrimary;
  final Color textSecondary;
  final VoidCallback onTap;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.cardColor,
    required this.textPrimary,
    required this.textSecondary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withOpacity(0.15)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(height: 10),
              Text(
                value,
                style: GoogleFonts.poppins(
                  color: textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Section Label ──────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String text;
  final Color textColor;
  const _SectionLabel({required this.text, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 16, 8),
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.poppins(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

// ── Profile Tile ───────────────────────────────────────────
class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color cardColor;
  final Color textPrimary;
  final Color textSecondary;
  final Color dividerColor;

  const _ProfileTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.cardColor,
    required this.textPrimary,
    required this.textSecondary,
    required this.dividerColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: dividerColor.withOpacity(0.5), width: 0.8),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      color: textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            trailing ??
                Icon(Icons.chevron_right_rounded,
                    color: textSecondary.withOpacity(0.3), size: 22),
          ],
        ),
      ),
    );
  }
}

