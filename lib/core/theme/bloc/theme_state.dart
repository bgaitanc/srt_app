import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeMode mode;
  final bool isDark;

  const ThemeState({
    required this.mode,
    required this.isDark,
  });

  factory ThemeState.initial() {
    return const ThemeState(
      mode: ThemeMode.light,
      isDark: false,
    );
  }

  ThemeState copyWith({
    ThemeMode? mode,
    bool? isDark,
  }) {
    return ThemeState(
      mode: mode ?? this.mode,
      isDark: isDark ?? this.isDark,
    );
  }

  @override
  List<Object> get props => [mode, isDark];
}
