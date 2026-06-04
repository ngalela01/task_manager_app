import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/application/providers/shared_preferences_provider.dart';

class ThemeNotifier extends Notifier<ThemeMode> {
  static const String _themeKey = 'themeMode';
  @override
  ThemeMode build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final savedTheme = prefs.getString(_themeKey);

    if (savedTheme == 'dark') {
      return ThemeMode.dark;
    }

    return ThemeMode.light;
  }

  void toggleTheme() {
    final prefs = ref.read(sharedPreferencesProvider);

    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    final value = state == ThemeMode.dark ? 'dark' : 'light';
    prefs.setString(_themeKey, value);
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);
