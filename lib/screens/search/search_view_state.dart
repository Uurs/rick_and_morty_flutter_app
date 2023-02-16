import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty_preview/model/character.dart';

part 'search_view_state.freezed.dart';

@freezed
class SearchViewState with _$SearchViewState {
  factory SearchViewState({
    required String? searchQuery,
    required List<Character> searchResults,
    required int page,
  }) = _SearchViewState;
}