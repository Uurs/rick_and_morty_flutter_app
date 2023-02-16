import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
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
