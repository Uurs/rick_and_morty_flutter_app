import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rick_and_morty_preview/localization.dart';
import 'package:rick_and_morty_preview/router.gr.dart';
import 'package:rick_and_morty_preview/screens/search/search_state_notifier.dart';
import 'package:rick_and_morty_preview/widgets/character_list_item.dart';

class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateProvider = ref.watch(searchStateProvider);
    final searchController = useTextEditingController();
    final scrollController = useScrollController();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        ref.read(searchStateProvider.notifier).loadNextPage();
      }
    });

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: localization(context).search_input_label,
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              ref
                  .read(searchStateProvider.notifier)
                  .search(searchController.text);
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
                controller: scrollController,
                separatorBuilder: (context, index) => const SizedBox(height: 4),
                itemCount: stateProvider.searchResults.length,
                itemBuilder: (context, index) {
                  return CharacterListItem(
                    character: stateProvider.searchResults[index],
                    onFavorite: (character) => ref
                        .read(searchStateProvider.notifier)
                        .toggleFavorite(character),
                    onClick: (ch) => AutoRouter.of(context)
                        .push(CharacterDetailsRoute(characterId: ch.id)),
                  );
                }),
          )
        ],
      ),
    );
  }
}
