import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_preview/repository/remote_datasource/api_dto/get_character_list_dto.dart';

void main() {
  test("test parsing", () {
    final file = File('test_resources/get_characters_page_1.json');
    final json = file.readAsStringSync();
    final decodedJson = jsonDecode(json);
    final result = GetCharacterListDto.fromJson(decodedJson);
    print(result);
  });
}
