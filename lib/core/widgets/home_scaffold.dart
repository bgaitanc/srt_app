import 'package:flutter/material.dart';
import '../../core/widgets/topbar.dart';
import '../../core/widgets/app_drawer.dart';

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({super.key});

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const List<Widget> _pages = <Widget>[
    Center(child: Text('Reservas', style: TextStyle(fontSize: 18))),
    Center(child: Text('Viajes', style: TextStyle(fontSize: 18))),
    Center(child: Text('Perfil', style: TextStyle(fontSize: 18))),
  ];

  void _onSelectTab(int index) {
    setState(() => _currentIndex = index);
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
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Abrir configuración')));
        },
        onLogout: () {
          Navigator.of(context).pushReplacementNamed('/login');
        },
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onSelectTab,
        selectedItemColor: const Color(0xFF0288D1),
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.calendar_today), label: 'Reservas'),
          BottomNavigationBarItem(icon: const Icon(Icons.flight_takeoff), label: 'Viajes'),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: 'Perfil'),
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
