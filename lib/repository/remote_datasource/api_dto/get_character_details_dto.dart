import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty_preview/repository/remote_datasource/api_dto/location_dto.dart';
import 'package:rick_and_morty_preview/repository/remote_datasource/api_dto/origin_dto.dart';

part 'get_character_details_dto.freezed.dart';
part 'get_character_details_dto.g.dart';

@freezed
class GetCharacterDetailsDto with _$GetCharacterDetailsDto {
  factory GetCharacterDetailsDto({
    required String created,
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
    required String url,
  }) = _GetCharacterDetailsDto;

  factory GetCharacterDetailsDto.fromJson(Map<String, dynamic> json) => _$GetCharacterDetailsDtoFromJson(json);
}
