import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rick_and_morty_preview/localization.dart';
import 'package:rick_and_morty_preview/model/character_details.dart';
import 'package:rick_and_morty_preview/repository/repository_character.dart';
import 'package:rick_and_morty_preview/screens/character_details/character_details_state_provider.dart';

class CharacterDetailsScreen extends HookConsumerWidget {
  CharacterDetailsScreen({@PathParam("id") required this.characterId});

  final int characterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadData = ref.watch(characterDetailsDataProvider(characterId));

    toggleFavorite() {
      ref
          .read(characterRepositoryProvider)
          .whenData((value) => value.toggleFavorite(characterId));
    }

    final content = loadData.when(
      data: (data) => _onDataLoaded(context, data, toggleFavorite),
      error: (ob, trace) => _onError(context),
      loading: () => _onLoading(),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => AutoRouter.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: content,
    );
  }

  Widget _onDataLoaded(
    BuildContext context,
    CharacterDetails details,
    Function toggleFavorite,
  ) {
    final theme = Theme.of(context);
    final loc = localization(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: FittedBox(
                  child: Image.network(
                    details.character.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  details.character.name,
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(
                  details.character.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color:
                      details.character.isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () => toggleFavorite(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _nameValueWidget(
                theme,
                loc.character_details_subtitle_status,
                details.character.status,
              ),
              const SizedBox(width: 16),
              _nameValueWidget(
                theme,
                loc.character_details_subtitle_species,
                details.character.species,
              ),
              const SizedBox(width: 16),
              _nameValueWidget(
                theme,
                loc.character_details_subtitle_gender,
                details.meta.gender,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _nameValueWidget(theme, loc.character_details_subtitle_origin,
                  details.meta.originLocation),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _nameValueWidget(
                theme,
                loc.character_details_subtitle_last_known_location,
                details.meta.lastKnownLocation,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _onError(BuildContext context) {
    return Column(
      children: [
        Text(
          localization(context).common_failed_to_fetch_data,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }

  Widget _onLoading() {
    return const Center(
      child: Text("Loading"),
    );
  }

  Widget _nameValueWidget(ThemeData theme, String name, String value) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Text(
            name,
            style: theme.textTheme.labelSmall,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
