import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../../home/presentation/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: BlocConsumer<AuthBloc, AuthState>(
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
                debugPrint('[LOGIN PAGE] Error al navegar a HomePage: $e');}
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AuthAuthenticated) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.check_circle_outline, color: Colors.green, size: 64),
                    SizedBox(height: 24),
                    Text('¡Login exitoso!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
                  TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Password')),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(LoginRequested(
                            emailController.text,
                            passwordController.text,
                          ));
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
