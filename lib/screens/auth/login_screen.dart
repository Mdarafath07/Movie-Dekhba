import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/auth_providers.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AnimationController _bgController;
  late Animation<double> _bgAnim;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
    _bgAnim = CurvedAnimation(parent: _bgController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(authNotifierProvider.notifier).signInWithEmail(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
  }

  Future<void> _loginWithGoogle() async {
    await ref.read(authNotifierProvider.notifier).signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<User?>>(authNotifierProvider, (previous, next) {
      next.when(
        data: (user) {
          if (user != null) context.go('/main');
        },
        error: (err, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(err.toString().replaceAll('Exception: ', '')),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        loading: () {},
      );
    });

    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState is AsyncLoading;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0D0F14) : const Color(0xFFF5F6FA),
      body: Stack(
        children: [
          // ── Animated gradient background ──────────────────
          AnimatedBuilder(
            animation: _bgAnim,
            builder: (context, _) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.lerp(
                      const Alignment(-0.6, -0.8),
                      const Alignment(0.6, -0.4),
                      _bgAnim.value,
                    )!,
                    radius: 1.2,
                    colors: isDark
                        ? [
                            const Color(0xFF3A0A0A).withOpacity(0.6),
                            const Color(0xFF0D0F14),
                          ]
                        : [
                            const Color(0xFFFFE5E5).withOpacity(0.8),
                            const Color(0xFFF5F6FA),
                          ],
                  ),
                ),
              );
            },
          ),

          // ── Decorative circles ────────────────────────────
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE50914).withOpacity(isDark ? 0.06 : 0.08),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            left: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF5A623).withOpacity(isDark ? 0.05 : 0.07),
              ),
            ),
          ),

          // ── Main content ──────────────────────────────────
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),

                      // ── Logo & Title ──────────────────────
                      Center(
                        child: Column(
                          children: [
                            // Film icon with glow
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFE50914), Color(0xFFB20710)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFE50914).withOpacity(0.4),
                                    blurRadius: 24,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.movie_creation_rounded,
                                  color: Colors.white, size: 40),
                            )
                                .animate()
                                .scale(
                                    delay: 100.ms,
                                    duration: 600.ms,
                                    curve: Curves.elasticOut)
                                .fade(duration: 400.ms),

                            const SizedBox(height: 20),

                            // Bangla title
                            Text(
                              '🎬 মুভি দেখবা',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.notoSansBengali(
                                color: isDark
                                    ? const Color(0xFFF0F2F5)
                                    : const Color(0xFF0D1117),
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            )
                                .animate()
                                .fade(delay: 200.ms, duration: 500.ms)
                                .slideY(begin: 0.3, end: 0),

                            const SizedBox(height: 6),

                            // English subtitle
                            Text(
                              'MOVIE DEKHBA',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFE50914),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 4,
                              ),
                            )
                                .animate()
                                .fade(delay: 300.ms, duration: 500.ms),

                            const SizedBox(height: 8),

                            // Bangladeshi tagline
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE50914).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: const Color(0xFFE50914)
                                        .withOpacity(0.3),
                                    width: 1),
                              ),
                              child: Text(
                                'Our favourite movie companion',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFFE50914),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                                .animate()
                                .fade(delay: 400.ms, duration: 500.ms),
                          ],
                        ),
                      ),

                      const SizedBox(height: 44),

                      // ── Sign in label ─────────────────────
                      Text(
                        'Sign In',
                        style: GoogleFonts.poppins(
                          color: isDark
                              ? const Color(0xFFF0F2F5)
                              : const Color(0xFF0D1117),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                          .animate()
                          .fade(delay: 450.ms, duration: 400.ms)
                          .slideX(begin: -0.15, end: 0),

                      const SizedBox(height: 4),
                      Text(
                        'Welcome back!',
                        style: GoogleFonts.notoSansBengali(
                          color: isDark
                              ? const Color(0xFF8B95A8)
                              : const Color(0xFF4A5568),
                          fontSize: 13,
                        ),
                      )
                          .animate()
                          .fade(delay: 500.ms, duration: 400.ms),

                      const SizedBox(height: 28),

                      // ── Email field ───────────────────────
                      CustomTextField(
                        hintText: 'Email address',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email_outlined,
                        textInputAction: TextInputAction.next,
                        validator: (val) =>
                            val != null && val.isNotEmpty ? null : 'Email required',
                      )
                          .animate()
                          .fade(delay: 550.ms, duration: 400.ms)
                          .slideY(begin: 0.2, end: 0),

                      const SizedBox(height: 14),

                      // ── Password field ────────────────────
                      CustomTextField(
                        hintText: 'Password',
                        controller: _passwordController,
                        isPassword: true,
                        prefixIcon: Icons.lock_outline_rounded,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => isLoading ? null : _login(),
                        validator: (val) =>
                            val != null && val.isNotEmpty ? null : 'Password required',
                      )
                          .animate()
                          .fade(delay: 600.ms, duration: 400.ms)
                          .slideY(begin: 0.2, end: 0),

                      const SizedBox(height: 28),

                      // ── Sign In button ────────────────────
                      _AnimatedButton(
                        onPressed: isLoading ? null : _login,
                        isLoading: isLoading,
                        label: 'Sign In',
                      )
                          .animate()
                          .fade(delay: 650.ms, duration: 400.ms)
                          .slideY(begin: 0.2, end: 0),

                      const SizedBox(height: 24),

                      // ── Divider ───────────────────────────
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: isDark
                                  ? const Color(0xFF2A3142)
                                  : const Color(0xFFE2E8F0),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 14),
                            child: Text(
                              'OR',
                              style: GoogleFonts.poppins(
                                color: isDark
                                    ? const Color(0xFF4A5568)
                                    : const Color(0xFF9BA3AF),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: isDark
                                  ? const Color(0xFF2A3142)
                                  : const Color(0xFFE2E8F0),
                            ),
                          ),
                        ],
                      )
                          .animate()
                          .fade(delay: 700.ms, duration: 400.ms),

                      const SizedBox(height: 24),

                      // ── Google button ─────────────────────
                      _GoogleButton(
                        onPressed: isLoading ? null : _loginWithGoogle,
                        isDark: isDark,
                      )
                          .animate()
                          .fade(delay: 750.ms, duration: 400.ms)
                          .slideY(begin: 0.2, end: 0),

                      const SizedBox(height: 32),

                      // ── Register link ─────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'You don\'t have an account? ',
                            style: GoogleFonts.notoSansBengali(
                              color: isDark
                                  ? const Color(0xFF8B95A8)
                                  : const Color(0xFF4A5568),
                              fontSize: 13,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.push('/register'),
                            child: Text(
                              'Register Now',
                              style: GoogleFonts.notoSansBengali(
                                color: const Color(0xFFE50914),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      )
                          .animate()
                          .fade(delay: 800.ms, duration: 400.ms),

                      const SizedBox(height: 40),

                      // ── Footer ────────────────────────────
                      Center(
                        child: Text(
                          'Developed by Arafath ❤️',
                          style: GoogleFonts.poppins(
                            color: isDark
                                ? const Color(0xFF4A5568)
                                : const Color(0xFF9BA3AF),
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                          .animate()
                          .fade(delay: 900.ms, duration: 400.ms),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Animated Sign In Button ────────────────────────────────
class _AnimatedButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String label;

  const _AnimatedButton({
    required this.onPressed,
    required this.isLoading,
    required this.label,
  });

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 120));
    _scaleAnim =
        Tween<double>(begin: 1.0, end: 0.96).animate(_pressController);
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pressController.forward(),
      onTapUp: (_) {
        _pressController.reverse();
        widget.onPressed?.call();
      },
      onTapCancel: () => _pressController.reverse(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            gradient: widget.onPressed == null
                ? null
                : const LinearGradient(
                    colors: [Color(0xFFE50914), Color(0xFFB20710)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
            color:
                widget.onPressed == null ? const Color(0xFF4A5568) : null,
            borderRadius: BorderRadius.circular(14),
            boxShadow: widget.onPressed != null
                ? [
                    BoxShadow(
                      color: const Color(0xFFE50914).withOpacity(0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: widget.isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                        strokeWidth: 2.5, color: Colors.white),
                  )
                : Text(
                    widget.label,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

// ── Google Sign In Button ──────────────────────────────────
class _GoogleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isDark;

  const _GoogleButton({required this.onPressed, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        backgroundColor: isDark
            ? const Color(0xFF1C2230)
            : const Color(0xFFFFFFFF),
        side: BorderSide(
          color: isDark
              ? const Color(0xFF2A3142)
              : const Color(0xFFE2E8F0),
          width: 1.2,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        foregroundColor:
            isDark ? const Color(0xFFF0F2F5) : const Color(0xFF0D1117),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(5),
            child: Image.asset(
              'lib/assets/google.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 14),
          Text(
            'Continue with Google',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

