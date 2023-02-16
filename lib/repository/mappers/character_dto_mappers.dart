import 'package:rick_and_morty_preview/model/character.dart';
import 'package:rick_and_morty_preview/repository/remote_datasource/api_dto/character_dto.dart';

extension CharacterDtoMapper on CharacterDto {
  Character toCharacter({bool isFavorite = false}) {
    return Character(
        id: id,
        name: name,
        status: status,
        species: species,
        image: image,
        isFavorite: isFavorite);
  }
}
