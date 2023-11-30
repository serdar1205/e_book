import 'package:e_book/features/domain/entity/entity.dart';
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'converter/list_string_converter.dart';
import 'dao/book_detail_dao.dart';

part 'book_detail_cache.g.dart';

@TypeConverters([ListStringConverter])
@Database(version: 1, entities: [BookDetailEntity])
abstract class BookDetailCache extends FloorDatabase{
  BookDetailDao get bookDetailDao;
}