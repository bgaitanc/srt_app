import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/session_manager.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback? onNavigateHome;
  final VoidCallback? onNavigateProfile;
  final VoidCallback? onNavigateSettings;
  final VoidCallback? onLogout;

  const AppDrawer({super.key, this.onNavigateHome, this.onNavigateProfile, this.onNavigateSettings, this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color(0xFF0288D1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.black54, size: 28),
                    ),
                    const SizedBox(width: 12),
                    Text('SRT', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(height: 10),
                Text('Tu compañero de viajes', style: GoogleFonts.montserrat(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    leading: const Icon(Icons.home, color: Color(0xFF0288D1)),
                    title: Text('Inicio', style: GoogleFonts.montserrat(fontWeight: FontWeight.w500)),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (onNavigateHome != null) onNavigateHome!();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person, color: Color(0xFF0288D1)),
                    title: Text('Perfil', style: GoogleFonts.montserrat(fontWeight: FontWeight.w500)),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (onNavigateProfile != null) onNavigateProfile!();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings, color: Color(0xFF0288D1)),
                    title: Text('Configuración', style: GoogleFonts.montserrat(fontWeight: FontWeight.w500)),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (onNavigateSettings != null) onNavigateSettings!();
                    },
                  ),
                  const Spacer(),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Color(0xFF0288D1)),
                    title: Text('Cerrar sesión', style: GoogleFonts.montserrat(fontWeight: FontWeight.w500)),
                    onTap: () async {
                      final navigator = Navigator.of(context);
                      navigator.pop();
                      await SessionManager.clearToken();
                      if (onLogout != null) {
                        onLogout!();
                      } else {
                        navigator.pushReplacementNamed('/login');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
