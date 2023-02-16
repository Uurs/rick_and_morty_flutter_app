import 'package:floor/floor.dart';
import 'package:rick_and_morty_preview/repository/local_datasource/entities/character_entity.dart';

@dao
abstract class CharacterDao {

  @Query("SELECT * FROM CharacterEntity WHERE (name LIKE '%' || :byName || '%') ORDER BY id LIMIT :count OFFSET :offset")
  Future<List<CharacterEntity>> getCharactersWithName(String byName, int offset, int count);

  @Query("SELECT * FROM CharacterEntity ORDER BY id LIMIT :count OFFSET :offset")
  Future<List<CharacterEntity>> getCharacters(int offset, int count);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCharacters(List<CharacterEntity> characters);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertOrUpdateCharacter(CharacterEntity entity);

  @Query("SELECT * FROM CharacterEntity WHERE id = :id")
  Future<CharacterEntity?> getCharacterById(int id);

  @Query("SELECT * FROM CharacterEntity WHERE isFavorite = 1")
  Stream<List<CharacterEntity>> getFavorites();
}