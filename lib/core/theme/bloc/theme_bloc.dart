import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _themeKey = 'theme_mode';

  ThemeBloc() : super(ThemeState.initial()) {
    on<ToggleTheme>(_onToggleTheme);
    on<SetTheme>(_onSetTheme);
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey) ?? 0;
    final mode = ThemeMode.values[themeIndex];
    add(SetTheme(mode));
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, mode.index);
  }

  void _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    final newMode = state.isDark ? ThemeMode.light : ThemeMode.dark;
    emit(state.copyWith(
      mode: newMode,
      isDark: newMode == ThemeMode.dark,
    ));
    _saveTheme(newMode);
  }

  void _onSetTheme(SetTheme event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
      mode: event.mode,
      isDark: event.mode == ThemeMode.dark,
    ));
    _saveTheme(event.mode);
  }
}
