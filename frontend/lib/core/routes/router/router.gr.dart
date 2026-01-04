// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
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
class LoginRoute extends _i8.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i9.Key? key,
    dynamic Function(bool)? onLoginResult,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         LoginRoute.name,
         args: LoginRouteArgs(key: key, onLoginResult: onLoginResult),
         initialChildren: children,
       );

  static const String name = 'LoginRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i4.LoginScreen(key: args.key, onLoginResult: args.onLoginResult);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.onLoginResult});

  final _i9.Key? key;

  final dynamic Function(bool)? onLoginResult;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLoginResult: $onLoginResult}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LoginRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
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
class RegisterRoute extends _i8.PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    _i9.Key? key,
    dynamic Function(bool)? onRegisterResult,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         RegisterRoute.name,
         args: RegisterRouteArgs(key: key, onRegisterResult: onRegisterResult),
         initialChildren: children,
       );

  static const String name = 'RegisterRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterRouteArgs>(
        orElse: () => const RegisterRouteArgs(),
      );
      return _i6.RegisterScreen(
        key: args.key,
        onRegisterResult: args.onRegisterResult,
      );
    },
  );
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.key, this.onRegisterResult});

  final _i9.Key? key;

  final dynamic Function(bool)? onRegisterResult;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key, onRegisterResult: $onRegisterResult}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RegisterRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
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
