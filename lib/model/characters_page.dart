import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty_preview/model/character.dart';

part 'characters_page.freezed.dart';

@freezed
class CharactersPage with _$CharactersPage {
  factory CharactersPage({
    required int page,
    required bool hasNext,
    required List<Character> characters,
  }) = _CharactersPage;
}
