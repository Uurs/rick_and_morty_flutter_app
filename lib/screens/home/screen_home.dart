import 'package:flutter/material.dart';
import 'package:rick_and_morty_preview/screens/favorites/screen_favorites.dart';
import 'package:rick_and_morty_preview/screens/search/screen_search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          children: const [
            SearchScreen(),
            FavoritesScreen(),
          ],
        ),
      ),
    );
  }
}
