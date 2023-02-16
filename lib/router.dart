import 'package:auto_route/auto_route.dart';
import 'package:rick_and_morty_preview/screens/character_details/screen_character_details.dart';
import 'package:rick_and_morty_preview/screens/home/screen_home.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: HomeScreen,
      initial: true,
    ),
    AutoRoute(
      path: '/character/:id',
      page: CharacterDetailsScreen,

    ),
  ],
)
class $AppRouter {}