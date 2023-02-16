import 'dart:async';

import 'package:floor/floor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rick_and_morty_preview/repository/local_datasource/character_dao.dart';
import 'package:rick_and_morty_preview/repository/local_datasource/entities/character_entity.dart';
import 'package:rick_and_morty_preview/repository/local_datasource/entities/character_meta_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

final appDatabaseProvider = FutureProvider(
    (ref) => $FloorFloorSqlDatabase.databaseBuilder('app_database.db').build());

final characterDaoProvider = FutureProvider<CharacterDao>((ref) async {
  return (await ref.watch(appDatabaseProvider.future)).characterDao;
});

@Database(version: 1, entities: [
  CharacterEntity,
  CharacterMetaEntity,
])
abstract class FloorSqlDatabase extends FloorDatabase {
  CharacterDao get characterDao;
}
