import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty_preview/repository/remote_datasource/api_dto/location_dto.dart';
import 'package:rick_and_morty_preview/repository/remote_datasource/api_dto/origin_dto.dart';

part 'character_dto.freezed.dart';
part 'character_dto.g.dart';

@freezed
class CharacterDto with _$CharacterDto {
  const factory CharacterDto(
      {required String created,
      required List<String> episode,
      required String gender,
      required int id,
      required String image,
      required LocationDto location,
      required String name,
      required OriginDto origin,
      required String species,
      required String status,
      required String type,
      required String url}) = _CharacterDto;

  factory CharacterDto.fromJson(Map<String, dynamic> json) => _$CharacterDtoFromJson(json);
}
