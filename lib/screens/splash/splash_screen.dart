import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/auth_providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    if (!kIsWeb) {
      await Future.delayed(const Duration(milliseconds: 3200));
    } else {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    
    if (!mounted) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      context.go('/main');
    } else {
      context.go('/login');
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0F14),
      body: Stack(
        children: [
          // ── Background gradient ───────────────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.3, -0.5),
                radius: 1.0,
                colors: [
                  Color(0xFF2A0A0A),
                  Color(0xFF0D0F14),
                ],
              ),
            ),
          ),

          // ── Decorative outer glow ring ────────────────────
          Center(
            child: AnimatedBuilder(
              animation: _pulseAnim,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnim.value,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE50914).withOpacity(0.12),
                        width: 1,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ── Second pulsing ring ───────────────────────────
          Center(
            child: AnimatedBuilder(
              animation: _pulseAnim,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.1 - (_pulseAnim.value - 0.85) * 0.5,
                  child: Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE50914).withOpacity(0.06),
                        width: 1,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ── Main center content ───────────────────────────
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Film icon with glow
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE50914), Color(0xFF8B0000)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE50914).withOpacity(0.45),
                        blurRadius: 40,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(
                      'lib/assets/applogo.png',
                      color: Colors.white,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
                    .animate()
                    .scale(
                        delay: 200.ms,
                        duration: 800.ms,
                        curve: Curves.elasticOut)
                    .fade(duration: 500.ms),

                const SizedBox(height: 28),

                // Bangla title
                Text(
                  'মুভি দেখবা',
                  style: GoogleFonts.notoSansBengali(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                )
                    .animate()
                    .fade(delay: 500.ms, duration: 600.ms)
                    .slideY(begin: 0.4, end: 0, curve: Curves.easeOut),

                const SizedBox(height: 6),

                Text(
                  'MOVIE DEKHBA',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFE50914),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 5,
                  ),
                )
                    .animate()
                    .fade(delay: 700.ms, duration: 500.ms),

                const SizedBox(height: 12),

                Text(
                  'Your favorite movie companion',
                  style: GoogleFonts.notoSansBengali(
                    color: const Color(0xFF8B95A8),
                    fontSize: 13,
                  ),
                )
                    .animate()
                    .fade(delay: 900.ms, duration: 500.ms),

                const SizedBox(height: 60),

                // Loading dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (i) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE50914),
                        shape: BoxShape.circle,
                      ),
                    )
                        .animate(
                            onPlay: (c) => c.repeat(reverse: true))
                        .scale(
                          delay: Duration(milliseconds: 1000 + i * 150),
                          duration: 600.ms,
                          begin: const Offset(0.5, 0.5),
                          end: const Offset(1.0, 1.0),
                          curve: Curves.easeInOut,
                        )
                        .fade(
                          delay: Duration(milliseconds: 1000 + i * 150),
                          duration: 600.ms,
                          begin: 0.3,
                          end: 1.0,
                        );
                  }),
                ),
              ],
            ),
          ),

          // ── Bottom branding ───────────────────────────────
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'Developed by Arafath ❤️',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF2A3142),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ).animate().fade(delay: 1500.ms, duration: 800.ms),
                const SizedBox(height: 4),
                Text(
                  'v1.0.3',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF2A3142),
                    fontSize: 10,
                  ),
                ).animate().fade(delay: 1600.ms, duration: 800.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

