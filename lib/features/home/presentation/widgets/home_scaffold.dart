import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:srt_app/core/di/injection.dart';
import 'topbar.dart';
import '../../../../core/presentation/navigation/app_drawer.dart';
import '../../../reservations/presentation/bloc/reservas_bloc.dart';
import '../../../reservations/presentation/bloc/reservas_event.dart';
import '../../../reservations/presentation/bloc/reservas_state.dart';
import '../../../reservations/domain/usecases/get_reservas_by_user.dart';
import '../../../profile/presentation/widgets/perfil_card.dart';
import '../../../reservations/presentation/widgets/reserva_card.dart';
import '../../../travels/presentation/widgets/viaje_card.dart';
import '../../../../core/utils/error_message_helper.dart';
import '../../../../core/infrastructure/storage/session_manager.dart';
import '../../../profile/presentation/bloc/user_info_bloc.dart';
import '../../../profile/presentation/bloc/user_info_event.dart';
import '../../../profile/presentation/bloc/user_info_state.dart';
import '../../../settings/presentation/pages/settings_page.dart';
import '../../../../core/theme/bloc/theme_bloc.dart';
import '../../../travels/presentation/bloc/viajes_bloc.dart';
import '../../../travels/presentation/bloc/viajes_event.dart';
import '../../../travels/presentation/bloc/viajes_state.dart';

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({super.key});

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ReservasBloc reservasBloc;
  late UserInfoBloc userInfoBloc;
  late ViajesBloc viajesBloc;
  int? _userId;

  @override
  void initState() {
    super.initState();
    reservasBloc = ReservasBloc(sl<GetReservasByUser>());
    userInfoBloc = sl<UserInfoBloc>();
    viajesBloc = sl<ViajesBloc>();
    _loadUserIdAndFetchData();
  }

  Future<void> _loadUserIdAndFetchData() async {
    final userId = await SessionManager.getUserId();
    if (userId == null) {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
      return;
    }
    setState(() {
      _userId = userId;
    });
    reservasBloc.add(FetchReservas(userId));
    userInfoBloc.add(const FetchUserInfo());
    viajesBloc.add(const FetchViajes());
  }

  @override
  void dispose() {
    reservasBloc.close();
    userInfoBloc.close();
    viajesBloc.close();
    super.dispose();
  }

  Widget _buildViajesPage() {
    return BlocBuilder<ViajesBloc, ViajesState>(
      bloc: viajesBloc,
      builder: (context, state) {
        if (state is ViajesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ViajesLoaded) {
          if (state.viajes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.flight_takeoff, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'No hay viajes disponibles',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: state.viajes.length,
            itemBuilder: (context, index) {
              return ViajeCard(viaje: state.viajes[index]);
            },
          );
        } else if (state is ViajesError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
                const SizedBox(height: 16),
                Text(
                  ErrorMessageHelper.getFriendlyMessage(state.failure.message),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => viajesBloc.add(const FetchViajes()),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        }
        return const Center(child: Text('Cargando viajes...'));
      },
    );
  }

  Widget _buildPerfilPage() {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      bloc: userInfoBloc,
      builder: (context, state) {
        if (state is UserInfoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserInfoLoaded) {
          final userInfo = state.userInfo;
          return PerfilCard(
            usuario: userInfo.usuario,
            nombres: userInfo.nombres,
            apellidos: userInfo.apellidos,
            correo: userInfo.correo,
            telefono: userInfo.telefono,
            miembroDesde: '16-11-2025', // TODO: Get from backend
          );
        } else if (state is UserInfoError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(ErrorMessageHelper.getFriendlyMessage(state.failure.message)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => userInfoBloc.add(const FetchUserInfo()),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        }
        return const Center(child: Text('Cargando perfil...'));
      },
    );
  }

  void _onSelectTab(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 0 && _userId != null) {
        reservasBloc.add(FetchReservas(_userId!));
      } else if (index == 1) {
        viajesBloc.add(const FetchViajes());
      } else if (index == 2) {
        userInfoBloc.add(const FetchUserInfo());
      }
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: TopBar(title: _pageTitle(), onMenuPressed: _openDrawer),
      drawer: AppDrawer(
        onNavigateHome: () => _onSelectTab(0),
        onNavigateProfile: () => _onSelectTab(2),
        onNavigateSettings: () {
          final themeBloc = context.read<ThemeBloc>();
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: themeBloc,
                child: const SettingsPage(),
              ),
            ),
          );
        },
        onLogout: () {
          Navigator.of(context).pushReplacementNamed('/login');
        },
      ),
      body: _currentIndex == 0
          ? BlocBuilder<ReservasBloc, ReservasState>(
              bloc: reservasBloc,
              builder: (context, state) {
                if (state is ReservasLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ReservasLoaded) {
                  if (state.reservas.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.event_busy,
                              size: 80,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No tienes reservas',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Cuando realices una reserva, aparecerá aquí',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: state.reservas.length,
                    itemBuilder: (context, index) {
                      final reserva = state.reservas[index];
                      return ReservaCard(
                        estado: 'Completado', // TODO: Map real estado
                        reserva: reserva,
                      );
                    },
                  );
                } else if (state is ReservasError) {
                  final friendlyMessage = ErrorMessageHelper.getFriendlyMessage(state.failure.message);
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red.shade300,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            friendlyMessage,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 24),
                          if (_userId != null)
                            ElevatedButton.icon(
                              onPressed: () {
                                reservasBloc.add(FetchReservas(_userId!));
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('Reintentar'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0288D1),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }
                return const Center(child: Text('Seleccione para ver reservas.'));
              },
            )
          : _currentIndex == 1
              ? _buildViajesPage()
              : _buildPerfilPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _onSelectTab(index);
        },
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        backgroundColor: Theme.of(context).colorScheme.surface,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Reservas'),
          BottomNavigationBarItem(icon: Icon(Icons.flight_takeoff), label: 'Viajes'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }

  String _pageTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Reservas';
      case 1:
        return 'Viajes';
      case 2:
        return 'Perfil';
      default:
        return 'SRT';
    }
  }
}
