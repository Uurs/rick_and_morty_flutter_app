// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import 'screens/character_details/screen_character_details.dart' as _i2;
import 'screens/home/screen_home.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomeScreen(),
      );
    },
    CharacterDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CharacterDetailsRouteArgs>(
          orElse: () =>
              CharacterDetailsRouteArgs(characterId: pathParams.getInt('id')));
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.CharacterDetailsScreen(characterId: args.characterId),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        _i3.RouteConfig(
          CharacterDetailsRoute.name,
          path: '/character/:id',
        ),
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.CharacterDetailsScreen]
class CharacterDetailsRoute
    extends _i3.PageRouteInfo<CharacterDetailsRouteArgs> {
  CharacterDetailsRoute({required int characterId})
      : super(
          CharacterDetailsRoute.name,
          path: '/character/:id',
          args: CharacterDetailsRouteArgs(characterId: characterId),
          rawPathParams: {'id': characterId},
        );

  static const String name = 'CharacterDetailsRoute';
}

class CharacterDetailsRouteArgs {
  const CharacterDetailsRouteArgs({required this.characterId});

  final int characterId;

  @override
  String toString() {
    return 'CharacterDetailsRouteArgs{characterId: $characterId}';
  }
}
