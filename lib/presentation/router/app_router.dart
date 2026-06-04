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
        AutoRoute(path: 'projects', page: ProjectRoute.page, initial: true),
        AutoRoute(path: 'today', page: TodayRoute.page),
        AutoRoute(path: 'week', page: WeekRoute.page),
        AutoRoute(path: 'settings', page: SettingsRoute.page),
      ],
    ),
  ];
}
