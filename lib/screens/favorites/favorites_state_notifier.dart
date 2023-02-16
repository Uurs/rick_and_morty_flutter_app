import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rick_and_morty_preview/logger.dart';
import 'package:rick_and_morty_preview/model/character.dart';
import 'package:rick_and_morty_preview/repository/repository_character.dart';

final favoritesStateProvider =
    StateNotifierProvider<FavoriteScreenStateNotifier, List<Character>>((ref) {
  return FavoriteScreenStateNotifier(
    ref.watch(characterRepositoryProvider.future),
  );
});

class FavoriteScreenStateNotifier extends StateNotifier<List<Character>> {

  FavoriteScreenStateNotifier(Future<CharacterRepository> repository) : super([]) {
    repository.then((value) => _onRepositoryReady(value));
  }

  late CharacterRepository _repository;

  void _onRepositoryReady(CharacterRepository repository) {
    _repository = repository;
    _getFavorites();
  }

  void _getFavorites() {
    _repository.getFavorites().forEach((element) {
      state = element;
    });
  }

  void toggleFavorite(Character ch) {
    _repository.toggleFavorite(ch.id).then((value) {
      logger.d("toggle favorite success");
    }).onError((error, stackTrace) {
      logger.d("toggle favorite failed", error);
    });
  }
}
