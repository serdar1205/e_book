import 'package:e_book/features/domain/entity/entity.dart';
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/awarded_books_dao.dart';

part 'awarded_books_cache.g.dart';

@Database(version: 1, entities: [AwardedBooksEntity])
abstract class AwardedBooksCache extends FloorDatabase{
  AwardedBooksDao get awardedBooksDao;
}
