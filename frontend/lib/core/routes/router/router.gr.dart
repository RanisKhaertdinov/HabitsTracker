// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:frontend/core/routes/navigation/bottom_nav_bar.dart' as _i2;
import 'package:frontend/features/add_habit/add_habit_screen.dart' as _i1;
import 'package:frontend/features/auth/login_screen.dart' as _i4;
import 'package:frontend/features/auth/register_screen.dart' as _i6;
import 'package:frontend/features/habits/habits_screen.dart' as _i3;
import 'package:frontend/features/profile/profile_screen.dart' as _i5;
import 'package:frontend/features/stats/stats_screen.dart' as _i7;

/// generated route for
/// [_i1.AddHabitScreen]
class AddHabitRoute extends _i8.PageRouteInfo<void> {
  const AddHabitRoute({List<_i8.PageRouteInfo>? children})
    : super(AddHabitRoute.name, initialChildren: children);

  static const String name = 'AddHabitRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddHabitScreen();
    },
  );
}

/// generated route for
/// [_i2.BottomNavBarScreen]
class BottomNavBarRoute extends _i8.PageRouteInfo<void> {
  const BottomNavBarRoute({List<_i8.PageRouteInfo>? children})
    : super(BottomNavBarRoute.name, initialChildren: children);

  static const String name = 'BottomNavBarRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.BottomNavBarScreen();
    },
  );
}

/// generated route for
/// [_i3.HabitsScreen]
class HabitsRoute extends _i8.PageRouteInfo<void> {
  const HabitsRoute({List<_i8.PageRouteInfo>? children})
    : super(HabitsRoute.name, initialChildren: children);

  static const String name = 'HabitsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.HabitsScreen();
    },
  );
}

/// generated route for
/// [_i4.LoginScreen]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute({List<_i8.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.LoginScreen();
    },
  );
}

/// generated route for
/// [_i5.ProfileScreen]
class ProfileRoute extends _i8.PageRouteInfo<void> {
  const ProfileRoute({List<_i8.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i5.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i6.RegisterScreen]
class RegisterRoute extends _i8.PageRouteInfo<void> {
  const RegisterRoute({List<_i8.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i7.StatsScreen]
class StatsRoute extends _i8.PageRouteInfo<void> {
  const StatsRoute({List<_i8.PageRouteInfo>? children})
    : super(StatsRoute.name, initialChildren: children);

  static const String name = 'StatsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.StatsScreen();
    },
  );
}
