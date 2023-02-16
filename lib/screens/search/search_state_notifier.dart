import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rick_and_morty_preview/logger.dart';
import 'package:rick_and_morty_preview/model/character.dart';
import 'package:rick_and_morty_preview/repository/repository_character.dart';
import 'package:rick_and_morty_preview/screens/search/search_view_state.dart';

final searchStateProvider =
    StateNotifierProvider<SearchViewStateNotifier, SearchViewState>((ref) =>
        SearchViewStateNotifier(ref.watch(characterRepositoryProvider.future)));

class SearchViewStateNotifier extends StateNotifier<SearchViewState> {
  late final CharacterRepository _repository;
  bool _isLoadingNextPage = false;

  SearchViewStateNotifier(Future<CharacterRepository> repository)
      : super(SearchViewState(searchQuery: "", searchResults: [], page: 1)) {
    repository.then((value) => _onRepositoryReady(value));
  }

  void _onRepositoryReady(CharacterRepository repository) {
    _repository = repository;
    search("");
    _repository.getFavorites().forEach((element) {
      _updateStateWithFavorites(element);
    });
  }

  void search(String name) {
    _repository.getCharacters(name, 1).then((value) {
      state = state.copyWith(
          searchQuery: name, searchResults: value.characters, page: value.page);
    });
  }

  void toggleFavorite(Character ch) {
    _repository.toggleFavorite(ch.id).then((value) {
      logger.d("toggle favorite success");
    }).onError((error, stackTrace) {
      logger.d("failed to toggle favorite", error);
    });
  }

  void loadNextPage() {
    if (_isLoadingNextPage) return;
    _isLoadingNextPage = true;
    _repository.getCharacters(state.searchQuery, state.page + 1).then((value) {
      state = state.copyWith(
          searchQuery: state.searchQuery,
          searchResults: state.searchResults + value.characters,
          page: value.page);
      _isLoadingNextPage = false;
    }).onError((error, stackTrace) {
      logger.e("failed to load next page", error);
      _isLoadingNextPage = false;
    });
  }

  void updateStateWithCharacter(Character newCharacter) {
    final newSearchResults = state.searchResults
        .map((e) => (e.id == newCharacter.id) ? newCharacter : e)
        .toList();
    state = state.copyWith(searchResults: newSearchResults);
  }

  void _updateStateWithFavorites(List<Character> favoriteCharacters) {
    final ids = favoriteCharacters.map((e) => e.id).toSet();
    final newSearchResults = state.searchResults
        .map((e) => e.copyWith(isFavorite: ids.contains(e.id)))
        .toList();
    state = state.copyWith(searchResults: newSearchResults);
  }
}
