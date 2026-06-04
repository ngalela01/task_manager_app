import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/application/providers/accent_color_provider.dart';
import 'package:task_manager_app/application/providers/theme_provider.dart';

@RoutePage()
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;
    final accentColor = ref.watch(accentColorProvider);
    final accentColors = [
      Colors.blue,
      Colors.green,
      Colors.deepOrange,
      Colors.purple,
    ];

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
        const SizedBox(height: 24),
        const Text(
          'Couleur accent',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: accentColors.map((color) {
            final isSelected = accentColor.toARGB32() == color.toARGB32();

            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: InkWell(
                onTap: () {
                  ref.read(accentColorProvider.notifier).changeColor(color);
                },
                child: CircleAvatar(
                  radius: isSelected ? 18 : 16,
                  backgroundColor: color,
                  child: isSelected
                      ? const Icon(Icons.check, color: Colors.white)
                      : null,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        const Text(
          'Raccourcis clavier',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const ListTile(
          leading: Icon(Icons.keyboard),
          title: Text('Ctrl + N'),
          subtitle: Text('Nouvelle tache'),
        ),
        const ListTile(
          leading: Icon(Icons.keyboard),
          title: Text('Ctrl + F'),
          subtitle: Text('Ouvrir / fermer la recherche'),
        ),
        const ListTile(
          leading: Icon(Icons.keyboard),
          title: Text('Ctrl + D'),
          subtitle: Text('Basculer le theme clair / sombre'),
        ),
      ],
    );
  }
}
