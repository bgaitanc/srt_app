import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthLogo extends StatelessWidget {
  final double height;
  const AuthLogo({super.key, this.height = 100});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/srt_logo_transparent.png',
          height: height,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}

class AuthTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const AuthTitle({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0288D1),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: GoogleFonts.montserrat(fontSize: 14, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class AuthInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final ValueChanged<bool>? onVisibilityToggle;
  final TextInputType keyboardType;
  final double delay;
  const AuthInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.delay = 0,
    this.onVisibilityToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(color: Colors.black38, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(icon, color: const Color(0xFF0288D1), size: 22),
        suffixIcon: onVisibilityToggle != null
            ? GestureDetector(
                onTap: () => onVisibilityToggle!(!obscureText),
                child: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
              )
            : null,
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
    );
  }
}

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool primary;
  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.primary = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary ? const Color(0xFF0288D1) : Colors.white,
        foregroundColor: primary ? Colors.white : const Color(0xFF0288D1),
        padding: const EdgeInsets.symmetric(vertical: 12),
        textStyle: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
