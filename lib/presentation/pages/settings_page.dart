import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/application/providers/theme_provider.dart';

@RoutePage()
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        SwitchListTile(
          title: Text(isDark ? 'Theme sombre' : 'Theme clair'),
          value: isDark,
          onChanged: (value) {
            ref.read(themeProvider.notifier).toggleTheme();
          },
        ),
      ],
    );
  }
}
