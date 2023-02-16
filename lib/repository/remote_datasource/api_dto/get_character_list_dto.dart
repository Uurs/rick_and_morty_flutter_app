import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty_preview/repository/remote_datasource/api_dto/character_dto.dart';
import 'package:rick_and_morty_preview/repository/remote_datasource/api_dto/info_dto.dart';

part 'get_character_list_dto.freezed.dart';
part 'get_character_list_dto.g.dart';

@freezed
class GetCharacterListDto with _$GetCharacterListDto {
  const factory GetCharacterListDto({
    required InfoDto info,
    required List<CharacterDto> results,
  }) = _GetCharacterListDto;

  factory GetCharacterListDto.fromJson(Map<String, dynamic> json) => _$GetCharacterListDtoFromJson(json);
}