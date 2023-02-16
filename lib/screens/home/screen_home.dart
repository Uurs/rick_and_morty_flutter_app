import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rick_and_morty_preview/localization.dart';
import 'package:rick_and_morty_preview/screens/favorites/screen_favorites.dart';
import 'package:rick_and_morty_preview/screens/search/screen_search.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final currentPage = useState(0);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage.value,
        onTap: (index) => pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.ease),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: localization(context).home_bottom_nav_bar_search,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: localization(context).home_bottom_nav_bar_favorites,
          ),
        ],
      ),
      body: SafeArea(
        child: PageView(
          onPageChanged: (index) => currentPage.value = index,
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
