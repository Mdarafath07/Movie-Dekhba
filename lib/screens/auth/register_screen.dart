import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/auth_providers.dart';
import '../../widgets/custom_text_field.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
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
    _confirmPasswordController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }
    await ref.read(authNotifierProvider.notifier).signUpWithEmail(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
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
                      const Alignment(0.6, -0.8),
                      const Alignment(-0.4, -0.3),
                      _bgAnim.value,
                    )!,
                    radius: 1.2,
                    colors: isDark
                        ? [
                            const Color(0xFF3A0A0A).withOpacity(0.5),
                            const Color(0xFF0D0F14),
                          ]
                        : [
                            const Color(0xFFFFE5E5).withOpacity(0.7),
                            const Color(0xFFF5F6FA),
                          ],
                  ),
                ),
              );
            },
          ),

          // ── Decorative circles ────────────────────────────
          Positioned(
            top: -100,
            left: -60,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE50914).withOpacity(isDark ? 0.05 : 0.07),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            right: -30,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF5A623).withOpacity(isDark ? 0.04 : 0.06),
              ),
            ),
          ),

          // ── Main content ──────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                // ── Back button ──────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1C2230)
                                : const Color(0xFFFFFFFF),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF2A3142)
                                  : const Color(0xFFE2E8F0),
                            ),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 18,
                            color: isDark
                                ? const Color(0xFFF0F2F5)
                                : const Color(0xFF0D1117),
                          ),
                        ),
                      ).animate().fade(duration: 300.ms).scale(),
                    ],
                  ),
                ),

                // ── Form ─────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 12),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 10),

                          // Title
                          Text(
                            'Create Account',
                            style: GoogleFonts.notoSansBengali(
                              color: isDark
                                  ? const Color(0xFFF0F2F5)
                                  : const Color(0xFF0D1117),
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                              .animate()
                              .fade(delay: 100.ms, duration: 400.ms)
                              .slideX(begin: -0.15, end: 0),

                          const SizedBox(height: 4),

                          Text(
                            'Join the Movie Dekhba community 🎬',
                            style: GoogleFonts.poppins(
                              color: isDark
                                  ? const Color(0xFF8B95A8)
                                  : const Color(0xFF4A5568),
                              fontSize: 13,
                            ),
                          )
                              .animate()
                              .fade(delay: 150.ms, duration: 400.ms),

                          const SizedBox(height: 32),

                          // Email
                          CustomTextField(
                            hintText: 'Email address',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icons.email_outlined,
                            textInputAction: TextInputAction.next,
                            validator: (val) => val != null && val.isNotEmpty
                                ? null
                                : 'Email required',
                          )
                              .animate()
                              .fade(delay: 200.ms, duration: 400.ms)
                              .slideY(begin: 0.2, end: 0),

                          const SizedBox(height: 14),

                          // Password
                          CustomTextField(
                            hintText: 'Password',
                            controller: _passwordController,
                            isPassword: true,
                            prefixIcon: Icons.lock_outline_rounded,
                            textInputAction: TextInputAction.next,
                            validator: (val) =>
                                val != null && val.length >= 6
                                    ? null
                                    : 'Min 6 characters',
                          )
                              .animate()
                              .fade(delay: 250.ms, duration: 400.ms)
                              .slideY(begin: 0.2, end: 0),

                          const SizedBox(height: 14),

                          // Confirm Password
                          CustomTextField(
                            hintText: 'Confirm Password',
                            controller: _confirmPasswordController,
                            isPassword: true,
                            prefixIcon: Icons.lock_outline_rounded,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) =>
                                isLoading ? null : _register(),
                            validator: (val) =>
                                val != null && val.isNotEmpty
                                    ? null
                                    : 'Required',
                          )
                              .animate()
                              .fade(delay: 300.ms, duration: 400.ms)
                              .slideY(begin: 0.2, end: 0),

                          const SizedBox(height: 32),

                          // Register button
                          _RegisterButton(
                            onPressed: isLoading ? null : _register,
                            isLoading: isLoading,
                          )
                              .animate()
                              .fade(delay: 350.ms, duration: 400.ms)
                              .slideY(begin: 0.2, end: 0),

                          const SizedBox(height: 28),

                          // Already have account
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account? ',
                                style: GoogleFonts.poppins(
                                  color: isDark
                                      ? const Color(0xFF8B95A8)
                                      : const Color(0xFF4A5568),
                                  fontSize: 13,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => context.pop(),
                                child: Text(
                                  'Sign In',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFFE50914),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          )
                              .animate()
                              .fade(delay: 400.ms, duration: 400.ms),

                          const SizedBox(height: 40),

                          Center(
                            child: Text(
                              'Developed by Arafath ❤️',
                              style: GoogleFonts.poppins(
                                color: isDark
                                    ? const Color(0xFF4A5568)
                                    : const Color(0xFF9BA3AF),
                                fontSize: 11,
                              ),
                            ),
                          )
                              .animate()
                              .fade(delay: 500.ms, duration: 400.ms),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisterButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  const _RegisterButton({required this.onPressed, required this.isLoading});

  @override
  State<_RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<_RegisterButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 120));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onPressed?.call();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
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
            color: widget.onPressed == null ? const Color(0xFF4A5568) : null,
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
                    'Create Account',
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
