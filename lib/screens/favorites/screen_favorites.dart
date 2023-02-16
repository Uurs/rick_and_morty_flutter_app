import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rick_and_morty_preview/router.gr.dart';
import 'package:rick_and_morty_preview/screens/favorites/favorites_state_notifier.dart';
import 'package:rick_and_morty_preview/widgets/character_list_item.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characters = ref.watch(favoritesStateProvider);

    onFavorite(ch) =>
        ref.read(favoritesStateProvider.notifier).toggleFavorite(ch);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 4),
        itemCount: characters.length,
        itemBuilder: (context, index) => CharacterListItem(
          character: characters[index],
          onFavorite: onFavorite,
          onClick: (ch) {
            AutoRouter.of(context)
                .push(CharacterDetailsRoute(characterId: ch.id));
          },
        ),
      ),
    );
  }
}
