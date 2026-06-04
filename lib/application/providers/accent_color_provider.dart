import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/application/providers/shared_preferences_provider.dart';

class AccentColorNotifier extends Notifier<Color> {
  static const String _accentColorKey = 'accentColor';

  @override
  Color build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final savedColor = prefs.getInt(_accentColorKey);

    if (savedColor == null) {
      return Colors.blue;
    }

    return Color(savedColor);
  }

  void changeColor(Color color) {
    final prefs = ref.read(sharedPreferencesProvider);

    state = color;
    prefs.setInt(_accentColorKey, color.toARGB32());
  }
}

final accentColorProvider = NotifierProvider<AccentColorNotifier, Color>(
  AccentColorNotifier.new,
);
