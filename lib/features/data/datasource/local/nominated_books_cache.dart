import 'package:e_book/features/domain/entity/entity.dart';
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dao/nominated_books_dao.dart';

part 'nominated_books_cache.g.dart';

@Database(version: 1, entities: [NominatedBooksEntity])
abstract class NominatedBooksCache extends FloorDatabase{
  NominatedBooksDao get nominatedBooksDao;
}
