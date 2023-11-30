import 'package:e_book/features/domain/entity/entity.dart';
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/weekly_popular_books_dao.dart';

part 'weekly_popular_books_cache.g.dart';

@Database(version: 1, entities: [WeeklyPopularBooksEntity])
abstract class WeeklyPopularBooksCache extends FloorDatabase{
  WeeklyPopularBooksDao get weeklyPopularBooksDao;
}
