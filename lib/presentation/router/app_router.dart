import 'package:auto_route/auto_route.dart';
import 'package:task_manager_app/presentation/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: MainLayoutRoute.page,
          children: [
            AutoRoute(path: 'dashboard', page: DashboardRoute.page, initial: true),
            AutoRoute(path: 'tasks', page: TaskListRoute.page),
            AutoRoute(path: 'tasks/:id', page: TaskDetailRoute.page),
            AutoRoute(path: 'settings', page: SettingsRoute.page),
            AutoRoute(path: 'about', page: AboutRoute.page),
          ],
        ),
      ];
}