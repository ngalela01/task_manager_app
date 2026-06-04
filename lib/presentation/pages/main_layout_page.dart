import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/presentation/router/app_router.gr.dart';
import 'package:task_manager_app/presentation/widgets/project_sidebar.dart';

@RoutePage()
class MainLayoutPage extends StatelessWidget {
  const MainLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        ProjectRoute(),
        TodayRoute(),
        WeekRoute(),
        SettingsRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: tabsRouter.activeIndex,
                onDestinationSelected: tabsRouter.setActiveIndex,
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
        );
      },
    );
  }
}
