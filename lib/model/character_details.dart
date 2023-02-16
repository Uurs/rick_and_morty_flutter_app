import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty_preview/model/character.dart';
import 'package:rick_and_morty_preview/model/character_meta.dart';

part 'character_details.freezed.dart';

@freezed
class CharacterDetails with _$CharacterDetails {
  const factory CharacterDetails({
    required Character character,
    required CharacterMeta meta,
}) = _CharacterDetails;
}