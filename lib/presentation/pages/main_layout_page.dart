import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/application/providers/search_provider.dart';
import 'package:task_manager_app/application/providers/search_visibility_provider.dart';
import 'package:task_manager_app/application/providers/theme_provider.dart';
import 'package:task_manager_app/presentation/router/app_router.gr.dart';
import 'package:task_manager_app/presentation/widgets/project_sidebar.dart';
import 'package:task_manager_app/presentation/widgets/task_form_dialog.dart';
import 'package:window_manager/window_manager.dart';

class NewTaskIntent extends Intent {
  const NewTaskIntent();
}

class ToggleSearchIntent extends Intent {
  const ToggleSearchIntent();
}

class ToggleThemeIntent extends Intent {
  const ToggleThemeIntent();
}

@RoutePage()
class MainLayoutPage extends ConsumerWidget {
  const MainLayoutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsRouter(
      routes: const [
        ProjectRoute(),
        TodayRoute(),
        WeekRoute(),
        SettingsRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        _updateWindowTitle(tabsRouter.activeIndex);

        return Shortcuts(
          shortcuts: const {
            SingleActivator(LogicalKeyboardKey.keyN, control: true):
                NewTaskIntent(),
            SingleActivator(LogicalKeyboardKey.keyF, control: true):
                ToggleSearchIntent(),
            SingleActivator(LogicalKeyboardKey.keyD, control: true):
                ToggleThemeIntent(),
          },
          child: Actions(
            actions: {
              NewTaskIntent: CallbackAction<NewTaskIntent>(
                onInvoke: (intent) {
                  showTaskFormDialog(context, ref);
                  return null;
                },
              ),
              ToggleSearchIntent: CallbackAction<ToggleSearchIntent>(
                onInvoke: (intent) {
                  final notifier = ref.read(searchVisibleProvider.notifier);
                  final isVisible = ref.read(searchVisibleProvider);

                  notifier.state = !isVisible;
                  if (isVisible) {
                    ref.read(searchTermProvider.notifier).state = '';
                  }

                  tabsRouter.setActiveIndex(0);
                  return null;
                },
              ),
              ToggleThemeIntent: CallbackAction<ToggleThemeIntent>(
                onInvoke: (intent) {
                  ref.read(themeProvider.notifier).toggleTheme();
                  return null;
                },
              ),
            },
            child: Focus(
              autofocus: true,
              child: Scaffold(
                body: Row(
                  children: [
                    NavigationRail(
                      selectedIndex: tabsRouter.activeIndex,
                      onDestinationSelected: (index) {
                        tabsRouter.setActiveIndex(index);
                        _updateWindowTitle(index);
                      },
                      labelType: NavigationRailLabelType.all,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.folder),
                          label: Text('Projets'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.today),
                          label: Text("Aujourd'hui"),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.calendar_month),
                          label: Text('Semaine'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.settings),
                          label: Text('Parametres'),
                        ),
                      ],
                    ),
                    const VerticalDivider(width: 1),
                    const ProjectSidebar(),
                    const VerticalDivider(width: 1),
                    Expanded(child: child),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _updateWindowTitle(int index) {
    final titles = [
      'Projets - TaskFlow',
      "Aujourd'hui - TaskFlow",
      'Cette semaine - TaskFlow',
      'Parametres - TaskFlow',
    ];

    windowManager.setTitle(titles[index]);
  }
}
