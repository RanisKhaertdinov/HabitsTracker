import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/routes/router/router.gr.dart';

@RoutePage()
class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HabitsRoute(),
        StatsRoute(),
        AddHabitRoute(),
        ProfileRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            iconSize: 30,
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) => _openPage(index, tabsRouter),
            items: getItems(),
          ),
        );
      },
    );
  }

  void _openPage(int index, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(index);
  }

  List<BottomNavigationBarItem> getItems() {
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
      BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ""),
      BottomNavigationBarItem(icon: Icon(Icons.add), label: ""),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
    ];
  }
}
