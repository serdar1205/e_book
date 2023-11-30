import 'package:e_book/features/domain/entity/entity.dart';
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dao/most_popular_books_dao.dart';

part 'most_popular_books_cache.g.dart';

@Database(version: 1, entities: [MostPopularBooksEntity])
abstract class MostPopularBooksCache extends FloorDatabase{
  MostPopularBooksDao get mostPopularBooksDao;
}
