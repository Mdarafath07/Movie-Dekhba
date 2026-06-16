import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateDialog extends StatefulWidget {
  final String latestVersion;
  final String updateLink;
  final List<String> newFeatures;

  const UpdateDialog({
    super.key,
    required this.latestVersion,
    required this.updateLink,
    required this.newFeatures,
  });

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _glowAnimation;
  late AnimationController _entranceController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 2.0, end: 8.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutBack,
    );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textPrimary = isDark ? Colors.white : const Color(0xFF1A1A1A);
    final textSecondary = isDark ? Colors.white70 : const Color(0xFF666666);
    // On web use solid card (no glassmorphism blur = no GPU hit)
    final cardBg = kIsWeb
        ? (isDark ? const Color(0xFF1E1E1E) : Colors.white)
        : (isDark
            ? const Color(0xFF1E1E1E).withOpacity(0.85)
            : Colors.white.withOpacity(0.85));

    return Material(
      color: Colors.transparent,
      child: PopScope(
        canPop: false,
        child: Stack(
          children: [
            // Background overlay — blur on native, simple overlay on web
            Positioned.fill(
              child: kIsWeb
                  ? Container(color: Colors.black.withOpacity(0.8))
                  : BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(color: Colors.black.withOpacity(0.5)),
                    ),
            ),

            Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _scaleAnimation,
                  child: AnimatedBuilder(
                    animation: _glowAnimation,
                    builder: (context, child) {
                      return Container(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 40),
                        constraints:
                            const BoxConstraints(maxWidth: 320),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color:
                                const Color(0xFFE50914).withOpacity(0.3),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFE50914)
                                  .withOpacity(0.15),
                              blurRadius: _glowAnimation.value * 2,
                              spreadRadius: _glowAnimation.value / 2,
                            ),
                          ],
                        ),
                        child: child,
                      );
                    },
                    // On web: skip ClipRRect + BackdropFilter for performance
                    child: kIsWeb
                        ? Padding(
                            padding: const EdgeInsets.all(24),
                            child: _DialogContent(
                              latestVersion: widget.latestVersion,
                              updateLink: widget.updateLink,
                              newFeatures: widget.newFeatures,
                              textPrimary: textPrimary,
                              textSecondary: textSecondary,
                              isDark: isDark,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(32),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: _DialogContent(
                                  latestVersion: widget.latestVersion,
                                  updateLink: widget.updateLink,
                                  newFeatures: widget.newFeatures,
                                  textPrimary: textPrimary,
                                  textSecondary: textSecondary,
                                  isDark: isDark,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogContent extends StatelessWidget {
  final String latestVersion;
  final String updateLink;
  final List<String> newFeatures;
  final Color textPrimary;
  final Color textSecondary;
  final bool isDark;

  const _DialogContent({
    required this.latestVersion,
    required this.updateLink,
    required this.newFeatures,
    required this.textPrimary,
    required this.textSecondary,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE50914).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.rocket_launch_rounded,
            color: Color(0xFFE50914),
            size: 32,
          ),
        ),
        const SizedBox(height: 16),

        Text(
          'Update Available',
          style: GoogleFonts.outfit(
            color: textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          'Version $latestVersion is here',
          style: GoogleFonts.poppins(
            color: textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),

        if (newFeatures.isNotEmpty) ...[
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.03)
                  : Colors.black.withOpacity(0.03),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: newFeatures
                  .take(3)
                  .map((f) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            const Icon(Icons.auto_awesome,
                                size: 12, color: Color(0xFFE50914)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                f,
                                style: GoogleFonts.poppins(
                                  color: textPrimary.withOpacity(0.8),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],

        const SizedBox(height: 24),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE50914).withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () async {
              final url = Uri.parse(updateLink);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE50914),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(
              'UPDATE NOW',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w900,
                fontSize: 14,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Recommended for you',
          style: GoogleFonts.poppins(
            color: textSecondary.withOpacity(0.6),
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
