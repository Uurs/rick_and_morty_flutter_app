import 'package:rick_and_morty_preview/model/character.dart';
import 'package:rick_and_morty_preview/model/character_details.dart';
import 'package:rick_and_morty_preview/model/character_meta.dart';
import 'package:rick_and_morty_preview/repository/remote_datasource/api_dto/get_character_details_dto.dart';

extension CharacterDetailsDtoMapper on GetCharacterDetailsDto {
  CharacterDetails toCharacterDetails({bool isFavorite = false}) {
    return CharacterDetails(
        character: extractCharacter(isFavorite), meta: extractMeta());
  }

  Character extractCharacter(bool isFavorite) {
    return Character(
      id: id,
      image: image,
      isFavorite: isFavorite,
      species: species,
      name: name,
      status: status,
    );
  }

  CharacterMeta extractMeta() {
    return CharacterMeta(
      lastKnownLocation: location.name,
      originLocation: origin.name,
      gender: gender,
    );
  }
}
