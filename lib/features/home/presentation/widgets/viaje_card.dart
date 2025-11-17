import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViajeCard extends StatelessWidget {
  final String imagenUrl;
  final String origen;
  final String destino;
  final String fecha;
  final String tipoTransporte;
  final String precio;
  final VoidCallback? onReservar;

  const ViajeCard({
    super.key,
    required this.imagenUrl,
    required this.origen,
    required this.destino,
    required this.fecha,
    required this.tipoTransporte,
    required this.precio,
    this.onReservar,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onReservar,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                imagenUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.image, size: 60, color: Colors.grey[500]),
                ),
              ),
            ),
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.55), Colors.black.withOpacity(0.15)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              left: 18,
              right: 18,
              bottom: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$origen → $destino', style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.white70, size: 16),
                      const SizedBox(width: 6),
                      Text(fecha, style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white70)),
                      const SizedBox(width: 16),
                      Icon(Icons.directions_bus, color: Colors.white70, size: 16),
                      const SizedBox(width: 6),
                      Text(tipoTransporte, style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white70)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('Precio: $precio', style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: Color(0xFF0288D1), fontSize: 15)),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0288D1),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                        ),
                        onPressed: onReservar ?? () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reserva iniciada (demo)')));
                        },
                        child: const Text('Reservar', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
