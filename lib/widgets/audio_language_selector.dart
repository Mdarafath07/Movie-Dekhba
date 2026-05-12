import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../core/utils/play_url_helper.dart';

/// Shows a bottom sheet listing available playback servers / audio languages.
/// When the user taps a chip the [onServerSelected] callback fires with the
/// chosen [PlayServer].  Optionally, pass [navigateOnSelect] = true to
/// automatically push '/play' with the server URL.
class AudioLanguageSelector extends StatefulWidget {
  final List<PlayServer> servers;
  final int initialIndex;
  final bool isDark;
  final Color textPrimary;
  final Color cardColor;
  final bool navigateOnSelect;
  final void Function(PlayServer server, int index)? onServerSelected;

  const AudioLanguageSelector({
    super.key,
    required this.servers,
    this.initialIndex = 0,
    required this.isDark,
    required this.textPrimary,
    required this.cardColor,
    this.navigateOnSelect = true,
    this.onServerSelected,
  });

  /// Convenience method — shows the bottom sheet and returns the selected
  /// [PlayServer] (or null if dismissed).
  static Future<({PlayServer server, int index})?> show(
    BuildContext context, {
    required List<PlayServer> servers,
    required int initialIndex,
    required bool isDark,
    required Color textPrimary,
    required Color cardColor,
    bool navigateOnSelect = true,
    void Function(PlayServer server, int index)? onServerSelected,
  }) {
    return showModalBottomSheet<({PlayServer server, int index})>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => AudioLanguageSelector(
        servers: servers,
        initialIndex: initialIndex,
        isDark: isDark,
        textPrimary: textPrimary,
        cardColor: cardColor,
        navigateOnSelect: navigateOnSelect,
        onServerSelected: onServerSelected,
      ),
    );
  }

  @override
  State<AudioLanguageSelector> createState() => _AudioLanguageSelectorState();
}

class _AudioLanguageSelectorState extends State<AudioLanguageSelector> {
  late int _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final textPrimary = widget.textPrimary;
    final cardColor = widget.cardColor;
    final textSecondary = isDark ? const Color(0xFF8B95A8) : const Color(0xFF4A5568);

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.5 : 0.15),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            24, 12, 24, 24 + MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Drag handle ──────────────────────────────────────────────
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white24 : Colors.black12,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // ── Title ────────────────────────────────────────────────────
            Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE50914),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Audio & Language',
                  style: GoogleFonts.poppins(
                    color: textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Choose a server or dubbed audio language',
              style: GoogleFonts.poppins(
                color: textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20),

            // ── Server chips ─────────────────────────────────────────────
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: widget.servers.asMap().entries.map((entry) {
                final i = entry.key;
                final server = entry.value;
                final isSelected = _selected == i;

                return GestureDetector(
                  onTap: () {
                    setState(() => _selected = i);
                    widget.onServerSelected?.call(server, i);

                    // Small delay to show selection feedback, then act
                    Future.delayed(const Duration(milliseconds: 180), () {
                      if (!mounted) return;
                      Navigator.of(context).pop(
                        (server: server, index: i),
                      );
                      if (widget.navigateOnSelect) {
                        context.push('/play', extra: server.url);
                      }
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFE50914).withOpacity(0.12)
                          : (isDark
                              ? Colors.white.withOpacity(0.05)
                              : Colors.black.withOpacity(0.04)),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFFE50914)
                            : (isDark
                                ? Colors.white.withOpacity(0.1)
                                : Colors.black.withOpacity(0.1)),
                        width: isSelected ? 1.5 : 1,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color:
                                    const Color(0xFFE50914).withOpacity(0.18),
                                blurRadius: 8,
                                spreadRadius: -2,
                              )
                            ]
                          : null,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          server.emoji,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          server.label,
                          style: GoogleFonts.poppins(
                            color: isSelected
                                ? const Color(0xFFE50914)
                                : textPrimary.withOpacity(0.8),
                            fontSize: 13,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.check_circle_rounded,
                            color: Color(0xFFE50914),
                            size: 15,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // ── Info note ────────────────────────────────────────────────
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.04)
                    : Colors.black.withOpacity(0.03),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.07)
                      : Colors.black.withOpacity(0.06),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 15,
                    color: textSecondary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Dubbed audio availability depends on the server. '
                      'If a language is not available, try a different server.',
                      style: GoogleFonts.poppins(
                        color: textSecondary,
                        fontSize: 11,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
