// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:frontend/core/router/router.dart' as _i3;
import 'package:frontend/features/add_habit/add_habit_screen.dart' as _i1;
import 'package:frontend/features/habits/habits_screen.dart' as _i4;
import 'package:frontend/features/profile/profile_screen.dart' as _i5;
import 'package:frontend/features/stats/stats_screen.dart' as _i6;
import 'package:frontend/models/bottom_nav_bar.dart' as _i2;

/// generated route for
/// [_i1.AddHabitScreen]
class AddHabitRoute extends _i7.PageRouteInfo<void> {
  const AddHabitRoute({List<_i7.PageRouteInfo>? children})
    : super(AddHabitRoute.name, initialChildren: children);

  static const String name = 'AddHabitRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddHabitScreen();
    },
  );
}

/// generated route for
/// [_i2.BottomNavBarScreen]
class BottomNavBarRoute extends _i7.PageRouteInfo<void> {
  const BottomNavBarRoute({List<_i7.PageRouteInfo>? children})
    : super(BottomNavBarRoute.name, initialChildren: children);

  static const String name = 'BottomNavBarRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.BottomNavBarScreen();
    },
  );
}

/// generated route for
/// [_i3.EmptyAddHabitPage]
class EmptyAddHabitRoute extends _i7.PageRouteInfo<void> {
  const EmptyAddHabitRoute({List<_i7.PageRouteInfo>? children})
    : super(EmptyAddHabitRoute.name, initialChildren: children);

  static const String name = 'EmptyAddHabitRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.EmptyAddHabitPage();
    },
  );
}

/// generated route for
/// [_i3.EmptyHabitsPage]
class EmptyHabitsRoute extends _i7.PageRouteInfo<void> {
  const EmptyHabitsRoute({List<_i7.PageRouteInfo>? children})
    : super(EmptyHabitsRoute.name, initialChildren: children);

  static const String name = 'EmptyHabitsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.EmptyHabitsPage();
    },
  );
}

/// generated route for
/// [_i3.EmptyProfilePage]
class EmptyProfileRoute extends _i7.PageRouteInfo<void> {
  const EmptyProfileRoute({List<_i7.PageRouteInfo>? children})
    : super(EmptyProfileRoute.name, initialChildren: children);

  static const String name = 'EmptyProfileRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.EmptyProfilePage();
    },
  );
}

/// generated route for
/// [_i3.EmptyStatsPage]
class EmptyStatsRoute extends _i7.PageRouteInfo<void> {
  const EmptyStatsRoute({List<_i7.PageRouteInfo>? children})
    : super(EmptyStatsRoute.name, initialChildren: children);

  static const String name = 'EmptyStatsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.EmptyStatsPage();
    },
  );
}

/// generated route for
/// [_i4.HabitsScreen]
class HabitsRoute extends _i7.PageRouteInfo<void> {
  const HabitsRoute({List<_i7.PageRouteInfo>? children})
    : super(HabitsRoute.name, initialChildren: children);

  static const String name = 'HabitsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.HabitsScreen();
    },
  );
}

/// generated route for
/// [_i5.ProfileScreen]
class ProfileRoute extends _i7.PageRouteInfo<void> {
  const ProfileRoute({List<_i7.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i6.StatsScreen]
class StatsRoute extends _i7.PageRouteInfo<void> {
  const StatsRoute({List<_i7.PageRouteInfo>? children})
    : super(StatsRoute.name, initialChildren: children);

  static const String name = 'StatsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.StatsScreen();
    },
  );
}
