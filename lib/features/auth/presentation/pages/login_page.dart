import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/auth_ui_components.dart';
import '../../../../core/di/injection.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../../home/presentation/pages/home_page.dart';
import 'register_page.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final ValueNotifier<bool> passwordObscure = ValueNotifier(true);
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB2EBF2), Color(0xFF0288D1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      width: size.width < 400 ? size.width * 0.95 : 360,
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.0),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.0),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                          if (state is AuthAuthenticated) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('¡Login exitoso!')),
                            );
                            try {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => HomePage()),
                              );
                            } catch (e) {
                              debugPrint(
                                '[LOGIN PAGE] Error al navegar a HomePage: $e',
                              );
                            }
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is AuthAuthenticated) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                    size: 64,
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    '¡Login exitoso!',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ).animate().fadeIn(duration: 600.ms);
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Bienvenido a SRT',
                                style: GoogleFonts.montserrat(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF0288D1),
                                ),
                                textAlign: TextAlign.center,
                              ).animate().fadeIn(
                                duration: 400.ms,
                                delay: 100.ms,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Explora tu aventura con nosotros',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.center,
                              ).animate().fadeIn(
                                duration: 400.ms,
                                delay: 200.ms,
                              ),
                              const SizedBox(height: 22),
                              AuthInput(
                                controller: emailController,
                                hintText: 'Usuario',
                                icon: Icons.person_outline,
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 10),
                              ValueListenableBuilder<bool>(
                                valueListenable: passwordObscure,
                                builder: (context, value, _) => AuthInput(
                                  controller: passwordController,
                                  hintText: 'Contraseña',
                                  icon: Icons.lock_outline,
                                  obscureText: value,
                                  onVisibilityToggle: (v) =>
                                      passwordObscure.value = v,
                                ),
                              ),
                              const SizedBox(height: 18),
                              AuthButton(
                                text: 'Iniciar Sesión',
                                onPressed: () {
                                  context.read<AuthBloc>().add(
                                    LoginRequested(
                                      emailController.text,
                                      passwordController.text,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => const RegisterPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Registrarse',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const ForgotPasswordPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      '¿Olvidaste tu contraseña?',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/srt_logo_transparent.png',
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
