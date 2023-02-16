import 'package:floor/floor.dart';

@entity
class CharacterEntity {
  CharacterEntity(
    this.id,
    this.name,
    this.status,
    this.species,
    this.image,
    this.isFavorite,
  );

  @primaryKey
  final int id;
  final String name;
  final String status;
  final String species;
  final String image;
  bool isFavorite;
}
