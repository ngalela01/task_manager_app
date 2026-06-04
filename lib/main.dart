import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/application/providers/accent_color_provider.dart';
import 'package:task_manager_app/application/providers/theme_provider.dart';
import 'package:task_manager_app/core/theme/app_theme.dart';
import 'package:task_manager_app/presentation/router/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/application/providers/shared_preferences_provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  const windowOptions = WindowOptions(
    size: Size(1000, 700),
    minimumSize: Size(800, 600),
    center: true,
    title: 'TaskFlow',
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

final appRouter = AppRouter();

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final accentColor = ref.watch(accentColorProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.light(accentColor),
      darkTheme: AppTheme.dark(accentColor),
      routerConfig: appRouter.config(),
    );
  }
}
