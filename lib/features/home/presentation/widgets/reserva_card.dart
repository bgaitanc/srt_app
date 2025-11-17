import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReservaCard extends StatefulWidget {
  final String estado;
  final String reservaId;
  final String origen;
  final String destino;
  final String fechaSalida;
  final String fechaLlegada;
  final String asientos;
  final String precio;
  final String tipoTransporte;
  final String vehiculo;
  final String modelo;
  final String marca;
  final String detalles;

  const ReservaCard({
    super.key,
    required this.estado,
    required this.reservaId,
    required this.origen,
    required this.destino,
    required this.fechaSalida,
    required this.fechaLlegada,
    required this.asientos,
    required this.precio,
    required this.tipoTransporte,
    required this.vehiculo,
    required this.modelo,
    required this.marca,
    required this.detalles,
  });

  @override
  State<ReservaCard> createState() => _ReservaCardState();
}

class _ReservaCardState extends State<ReservaCard> {
  bool _expanded = false;

  void _showTicketModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Detalles de la Reserva', style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(widget.detalles, style: GoogleFonts.montserrat(fontSize: 16)),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.close),
                label: const Text('Cerrar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0288D1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final estadoColor = widget.estado == 'Completado' ? Colors.green : Colors.orange;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: estadoColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(widget.estado, style: GoogleFonts.montserrat(color: estadoColor, fontWeight: FontWeight.w600, fontSize: 13)),
                ),
                const SizedBox(width: 14),
                Flexible(
                  child: Text('ID: ${widget.reservaId}', style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, fontSize: 13), overflow: TextOverflow.ellipsis),
                ),
                IconButton(
                  icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more, color: const Color(0xFF0288D1)),
                  onPressed: () => setState(() => _expanded = !_expanded),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${widget.origen} → ${widget.destino}', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.black38),
                    const SizedBox(width: 6),
                    Flexible(child: Text('Salida: ${widget.fechaSalida}', style: GoogleFonts.montserrat(fontSize: 13), overflow: TextOverflow.ellipsis)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.event_seat, size: 16, color: Colors.black38),
                    const SizedBox(width: 6),
                    Flexible(child: Text('Asientos: ${widget.asientos}', style: GoogleFonts.montserrat(fontSize: 13), overflow: TextOverflow.ellipsis)),
                    const SizedBox(width: 18),
                    Icon(Icons.attach_money, size: 16, color: Colors.black38),
                    const SizedBox(width: 6),
                    Flexible(child: Text('Precio: ${widget.precio}', style: GoogleFonts.montserrat(fontSize: 13), overflow: TextOverflow.ellipsis)),
                  ],
                ),
              ],
            ),
            if (_expanded)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16, color: Colors.black38),
                        const SizedBox(width: 6),
                        Flexible(child: Text('Salida: ${widget.fechaSalida}', style: GoogleFonts.montserrat(fontSize: 13), overflow: TextOverflow.ellipsis)),
                        const SizedBox(width: 18),
                        Icon(Icons.calendar_today, size: 16, color: Colors.black38),
                        const SizedBox(width: 6),
                        Flexible(child: Text('Llegada: ${widget.fechaLlegada}', style: GoogleFonts.montserrat(fontSize: 13), overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.directions_bus, color: Colors.black38, size: 18),
                        const SizedBox(width: 8),
                        Flexible(child: Text('Transporte: ${widget.tipoTransporte}', style: GoogleFonts.montserrat(fontSize: 14), overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.directions_car, color: Colors.black38, size: 18),
                        const SizedBox(width: 8),
                        Flexible(child: Text('Vehículo: ${widget.vehiculo}', style: GoogleFonts.montserrat(fontSize: 14), overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.black38, size: 18),
                        const SizedBox(width: 8),
                        Flexible(child: Text('Modelo: ${widget.modelo}, Marca: ${widget.marca}', style: GoogleFonts.montserrat(fontSize: 14), overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.receipt_long),
                        label: const Text('Ver ticket'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0288D1),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: _showTicketModal,
                      ),
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
