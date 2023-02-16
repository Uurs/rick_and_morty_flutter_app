import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_meta.freezed.dart';

@freezed
class CharacterMeta with _$CharacterMeta {
  factory CharacterMeta(
      {required String gender,
      required String lastKnownLocation,
      required String originLocation}) = _CharacterMeta;
}
