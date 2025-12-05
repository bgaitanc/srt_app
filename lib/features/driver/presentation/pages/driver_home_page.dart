import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:srt_app/core/di/injection.dart';
import '../bloc/driver_trips_bloc.dart';
import '../bloc/driver_trips_event.dart';
import '../bloc/driver_trips_state.dart';
import '../widgets/driver_trip_card.dart';
import 'qr_scanner_page.dart';
import '../bloc/ticket_scanner_bloc.dart';

class DriverHomePage extends StatelessWidget {
  const DriverHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DriverTripsBloc, DriverTripsState>(
        listener: (context, state) {
          if (state is TripCompletedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: 12),
                    Text('Viaje completado exitosamente'),
                  ],
                ),
                backgroundColor: Color(0xFF10B981),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DriverTripsInitial) {
            context.read<DriverTripsBloc>().add(LoadAssignedTripsEvent());
            return Center(child: CircularProgressIndicator());
          }

          if (state is DriverTripsLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is DriverTripsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    state.message,
                    style: GoogleFonts.inter(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<DriverTripsBloc>().add(LoadAssignedTripsEvent());
                    },
                    child: Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          if (state is DriverTripsLoaded) {
            if (state.trips.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_shipping_outlined, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No tienes viajes asignados',
                      style: GoogleFonts.inter(fontSize: 18, color: Colors.grey.shade700),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<DriverTripsBloc>().add(RefreshTripsEvent());
              },
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8),
                itemCount: state.trips.length,
                itemBuilder: (context, index) {
                  final trip = state.trips[index];
                  return DriverTripCard(
                    trip: trip,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (routeCtx) => BlocProvider<TicketScannerBloc>(
                            create: (_) => sl<TicketScannerBloc>(),
                            child: QRScannerPage(trip: trip),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
