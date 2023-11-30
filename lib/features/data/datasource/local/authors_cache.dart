import 'package:e_book/features/data/datasource/local/dao/authors_dao.dart';
import 'package:e_book/features/domain/entity/entity.dart';
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'authors_cache.g.dart';

@Database(version: 1, entities: [MostPopularAuthorsEntity])
abstract class AuthorsCache extends FloorDatabase{
  AuthorsDao get authorsDao;
}
