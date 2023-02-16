import 'package:rick_and_morty_preview/model/character_meta.dart';
import 'package:rick_and_morty_preview/repository/local_datasource/entities/character_meta_entity.dart';

extension CharacterMetaEntityMapper on CharacterMetaEntity {
  CharacterMeta toCharacterMeta() {
    return CharacterMeta(
      gender: gender,
      lastKnownLocation: lastKnownLocation,
      originLocation: originLocation,
    );
  }
}
