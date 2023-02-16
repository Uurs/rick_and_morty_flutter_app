import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rick_and_morty_preview/model/character_details.dart';
import 'package:rick_and_morty_preview/repository/remote_datasource/api_dto/get_character_details_dto.dart';
import 'package:rick_and_morty_preview/repository/remote_datasource/api_dto/get_character_details_dto.dart';
import 'package:rick_and_morty_preview/repository/remote_datasource/api_dto/get_character_list_dto.dart';

final characterApiServiceProvider = Provider<CharacterApiService>((ref) {
  return DioCharacterApiService();
});

abstract class CharacterApiService {
  Future<GetCharacterListDto> searchCharacters(String? byName, int page);
  Future<GetCharacterDetailsDto> getCharacterDetails(int id);
}

class DioCharacterApiService extends CharacterApiService {
  final _dio = Dio(
    BaseOptions(baseUrl: 'https://rickandmortyapi.com/api/'),
  );

  DioCharacterApiService() {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  @override
  Future<GetCharacterListDto> searchCharacters(String? byName, int page) async {
    final response = await _dio.get("character", queryParameters: {
      "name": byName,
      "page": page,
    });
    return GetCharacterListDto.fromJson(response.data);
  }

  @override
  Future<GetCharacterDetailsDto> getCharacterDetails(int id) async {
    final response = await _dio.get("character/$id");
    return GetCharacterDetailsDto.fromJson(response.data);
  }
}
