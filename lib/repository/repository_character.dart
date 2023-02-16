import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rick_and_morty_preview/constants.dart';
import 'package:rick_and_morty_preview/logger.dart';
import 'package:rick_and_morty_preview/model/character.dart';
import 'package:rick_and_morty_preview/model/character_details.dart';
import 'package:rick_and_morty_preview/model/characters_page.dart';
import 'package:rick_and_morty_preview/platform/internet_connection_observer.dart';
import 'package:rick_and_morty_preview/repository/local_datasource/app_database.dart';
import 'package:rick_and_morty_preview/repository/local_datasource/character_dao.dart';
import 'package:rick_and_morty_preview/repository/local_datasource/entities/character_entity.dart';
import 'package:rick_and_morty_preview/repository/mappers/character_details_dto_mapper.dart';
import 'package:rick_and_morty_preview/repository/mappers/character_dto_mappers.dart';
import 'package:rick_and_morty_preview/repository/mappers/character_entity_mappers.dart';
import 'package:rick_and_morty_preview/repository/remote_datasource/api_service.dart';

final characterRepositoryProvider = FutureProvider<CharacterRepository>((ref) async {
  final apiService = ref.watch(characterApiServiceProvider);
  final characterDao = await ref.watch(characterDaoProvider.future);
  final connectivityObserver = ref.watch(connectivityObserverProvider);
  return _CharacterRepository(characterDao, apiService, connectivityObserver);
});

abstract class CharacterRepository {
  Future<CharactersPage> getCharacters(String? byName, int page);

  Future<Character> getCharacter(int id);

  Stream<List<Character>> getFavorites();

  Future<void> toggleFavorite(int id);

  Future<CharacterDetails> getCharacterDetails(int id);
}

class _CharacterRepository extends CharacterRepository {
  _CharacterRepository(
      this._characterDao, this._apiService, this._connectivityObserver);

  final CharacterDao _characterDao;
  final CharacterApiService _apiService;
  final ConnectivityObserver _connectivityObserver;

  @override
  Future<Character> getCharacter(int id) async {
    // TODO: implement getCharacter
    throw UnimplementedError();
  }

  @override
  Future<CharactersPage> getCharacters(String? byName, int page) async {
    if (await _connectivityObserver.isConnected) {
      return _fetchCharactersFromRemote(byName, page);
    } else {
      return _fetchFromLocal(byName, page);
    }
  }

  @override
  Stream<List<Character>> getFavorites() {
    return _characterDao
        .getFavorites()
        .map((list) => list.map((item) => item.toCharacter()).toList());
  }

  @override
  Future<void> toggleFavorite(int id) async {
    final localCharacter = await _characterDao.getCharacterById(id);
    if (localCharacter == null) throw Exception("failed to find cached value");

    localCharacter.isFavorite = !localCharacter.isFavorite;
    await _characterDao.insertOrUpdateCharacter(localCharacter);
  }

  @override
  Future<CharacterDetails> getCharacterDetails(int id) async {
    final characterDetails = await _apiService.getCharacterDetails(id);
    final favorites = await _characterDao.getFavorites().first;
    final isFavorite = favorites.any((element) => element.id == id);
    return characterDetails.toCharacterDetails(isFavorite: isFavorite);
  }

  Future<CharactersPage> _fetchCharactersFromRemote(
      String? byName, int page) async {
    final searchResponse = await _apiService.searchCharacters(byName, page);
    final favoriteCharacters =
        await _characterDao.getFavorites().first;
    final favoriteIds = favoriteCharacters.map((e) => e.id).toSet();
    final characters = searchResponse.results
        .map((e) => e.toCharacter(isFavorite: favoriteIds.contains(e.id)))
        .toList();

    await _characterDao
        .insertCharacters(characters.map((e) => e.toEntity()).toList());
    return CharactersPage(
        page: page,
        hasNext: searchResponse.info.next != null,
        characters: characters);
  }

  Future<CharactersPage> _fetchFromLocal(String? byName, int page) {
    final offset = page * PAGE_ITEM_COUNT;
    Future<List<CharacterEntity>> future;
    if (byName != null) {
      future = _characterDao
          .getCharactersWithName(byName, offset, PAGE_ITEM_COUNT);
    } else {
      future = _characterDao.getCharacters(offset, PAGE_ITEM_COUNT);
    }
    return future
        .then((value) => value.map((e) => e.toCharacter()))
        .then((value) => CharactersPage(
            page: page,
            hasNext: value.length % PAGE_ITEM_COUNT == 0,
            // TODO replace it with correct check
            characters: value.toList()));
  }
}
