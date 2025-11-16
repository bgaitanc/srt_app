import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/auth_ui_components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../../../core/di/injection.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nombreController = TextEditingController();
    final apellidoController = TextEditingController();
    final usuarioController = TextEditingController();
    final correoController = TextEditingController();
    final telefonoController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmController = TextEditingController();
    final ValueNotifier<bool> passwordObscure = ValueNotifier(true);
    final ValueNotifier<bool> confirmObscure = ValueNotifier(true);
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('¡Registro exitoso!')));
            nombreController.clear();
            apellidoController.clear();
            usuarioController.clear();
            correoController.clear();
            telefonoController.clear();
            passwordController.clear();
            confirmController.clear();
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Scaffold(
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
              child: Center(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 8),
                          AuthLogo(height: 100),
                          const SizedBox(height: 12),
                          AuthTitle(
                            title: 'Crear cuenta',
                            subtitle: 'Completa los datos para registrarte',
                          ),
                          const SizedBox(height: 22),
                          AuthInput(
                            controller: nombreController,
                            hintText: 'Nombre',
                            icon: Icons.person,
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(height: 10),
                          AuthInput(
                            controller: apellidoController,
                            hintText: 'Apellido',
                            icon: Icons.person_outline,
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(height: 10),
                          AuthInput(
                            controller: usuarioController,
                            hintText: 'Usuario',
                            icon: Icons.account_circle_outlined,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 10),
                          AuthInput(
                            controller: correoController,
                            hintText: 'Correo electrónico',
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 10),
                          AuthInput(
                            controller: telefonoController,
                            hintText: 'Teléfono',
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
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
                          const SizedBox(height: 10),
                          ValueListenableBuilder<bool>(
                            valueListenable: confirmObscure,
                            builder: (context, value, _) => AuthInput(
                              controller: confirmController,
                              hintText: 'Confirmar contraseña',
                              icon: Icons.lock_outline,
                              obscureText: value,
                              onVisibilityToggle: (v) =>
                                  confirmObscure.value = v,
                            ),
                          ),
                          const SizedBox(height: 18),
                          state is AuthLoading
                              ? const Center(child: CircularProgressIndicator())
                              : AuthButton(
                                  text: 'Registrarse',
                                  onPressed: () {
                                    context.read<AuthBloc>().add(
                                      RegisterRequested(
                                        nombre: nombreController.text,
                                        apellido: apellidoController.text,
                                        usuario: usuarioController.text,
                                        correo: correoController.text,
                                        telefono: telefonoController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                                  },
                                ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Volver a Iniciar Sesión',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
