import 'package:floor/floor.dart';

@entity
class CharacterMetaEntity {
  CharacterMetaEntity(
    this.characterId,
    this.gender,
    this.lastKnownLocation,
    this.originLocation,
  );

  @primaryKey
  final int characterId;
  final String gender;
  final String lastKnownLocation;
  final String originLocation;
}
