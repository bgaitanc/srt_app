import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleTheme extends ThemeEvent {
  const ToggleTheme();
}

class SetTheme extends ThemeEvent {
  final ThemeMode mode;

  const SetTheme(this.mode);

  @override
  List<Object> get props => [mode];
}
