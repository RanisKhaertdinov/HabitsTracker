import 'package:auto_route/auto_route.dart';
import 'package:frontend/core/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: BottomNavBarRoute.page,
      children: [
        AutoRoute(path: 'habits', page: HabitsRoute.page),
        AutoRoute(path: 'stats', page: StatsRoute.page),
        AutoRoute(path: 'add', page: AddHabitRoute.page),
        AutoRoute(path: 'profile', page: ProfileRoute.page),
      ],
    ),
  ];
}

@RoutePage()
class EmptyHabitsPage extends AutoRouter {
  const EmptyHabitsPage({super.key});
}

@RoutePage()
class EmptyStatsPage extends AutoRouter {
  const EmptyStatsPage({super.key});
}

@RoutePage()
class EmptyAddHabitPage extends AutoRouter {
  const EmptyAddHabitPage({super.key});
}

@RoutePage()
class EmptyProfilePage extends AutoRouter {
  const EmptyProfilePage({super.key});
}
