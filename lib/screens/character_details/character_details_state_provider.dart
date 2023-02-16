import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rick_and_morty_preview/model/character_details.dart';
import 'package:rick_and_morty_preview/repository/repository_character.dart';

final characterDetailsDataProvider =
    StreamProvider.family<CharacterDetails, int>((ref, id) async* {
  final repository = await ref.watch(characterRepositoryProvider.future);
  final details = await repository.getCharacterDetails(id);
  await for (final favorites in repository.getFavorites()) {
    final isFavorite = favorites.any((element) => element.id == id);
    yield details.copyWith(character: details.character.copyWith(isFavorite: isFavorite));
  }
});
