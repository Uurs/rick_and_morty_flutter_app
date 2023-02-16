import 'package:rick_and_morty_preview/model/character_meta.dart';
import 'package:rick_and_morty_preview/repository/local_datasource/entities/character_meta_entity.dart';

extension CharacterMetaMapper on CharacterMeta {
  CharacterMetaEntity toEntity(int characterId) {
    return CharacterMetaEntity(
      characterId,
      gender,
      lastKnownLocation,
      originLocation,
    );
  }
}
