import 'package:e_book/features/domain/entity/entity.dart';
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'converter/author_books_converter.dart';
import 'converter/list_string_converter.dart';
import 'dao/author_info_dao.dart';

part 'author_info_cache.g.dart';

@TypeConverters([ListStringConverter,AuthorBooksConverter])
@Database(version: 1, entities: [AuthorInfoEntity])
abstract class AuthorInfoCache extends FloorDatabase{
  AuthorInfoDao get authorInfoDao;
}