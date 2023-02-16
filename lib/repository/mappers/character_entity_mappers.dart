import 'package:rick_and_morty_preview/model/character.dart';
import 'package:rick_and_morty_preview/repository/local_datasource/entities/character_entity.dart';

extension CharacterEntityMappers on CharacterEntity {
  Character toCharacter() {
    return Character(
        id: id,
        name: name,
        status: status,
        species: species,
        image: image,
        isFavorite: isFavorite);
  }
}

extension CharacterToEntityMapper on Character {
  CharacterEntity toEntity() {
    return CharacterEntity(id, name, status, species, image, isFavorite);
  }
}
