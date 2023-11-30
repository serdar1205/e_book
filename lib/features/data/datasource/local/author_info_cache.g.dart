// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_info_cache.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAuthorInfoCache {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AuthorInfoCacheBuilder databaseBuilder(String name) =>
      _$AuthorInfoCacheBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AuthorInfoCacheBuilder inMemoryDatabaseBuilder() =>
      _$AuthorInfoCacheBuilder(null);
}

class _$AuthorInfoCacheBuilder {
  _$AuthorInfoCacheBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AuthorInfoCacheBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AuthorInfoCacheBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AuthorInfoCache> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AuthorInfoCache();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AuthorInfoCache extends AuthorInfoCache {
  _$AuthorInfoCache([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AuthorInfoDao? _authorInfoDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `author_info` (`id` INTEGER, `authorId` INTEGER, `name` TEXT, `image` TEXT, `rating` REAL, `info` TEXT, `genres` TEXT, `authorBooks` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AuthorInfoDao get authorInfoDao {
    return _authorInfoDaoInstance ??= _$AuthorInfoDao(database, changeListener);
  }
}

class _$AuthorInfoDao extends AuthorInfoDao {
  _$AuthorInfoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _authorInfoEntityInsertionAdapter = InsertionAdapter(
            database,
            'author_info',
            (AuthorInfoEntity item) => <String, Object?>{
                  'id': item.id,
                  'authorId': item.authorId,
                  'name': item.name,
                  'image': item.image,
                  'rating': item.rating,
                  'info': item.info,
                  'genres': _listStringConverter.encode(item.genres),
                  'authorBooks': _authorBooksConverter.encode(item.authorBooks)
                }),
        _authorInfoEntityUpdateAdapter = UpdateAdapter(
            database,
            'author_info',
            ['id'],
            (AuthorInfoEntity item) => <String, Object?>{
                  'id': item.id,
                  'authorId': item.authorId,
                  'name': item.name,
                  'image': item.image,
                  'rating': item.rating,
                  'info': item.info,
                  'genres': _listStringConverter.encode(item.genres),
                  'authorBooks': _authorBooksConverter.encode(item.authorBooks)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AuthorInfoEntity> _authorInfoEntityInsertionAdapter;

  final UpdateAdapter<AuthorInfoEntity> _authorInfoEntityUpdateAdapter;

  @override
  Future<AuthorInfoEntity?> getAuthorInfoById(int id) async {
    return _queryAdapter.query('SELECT * FROM author_info WHERE authorId = ?1',
        mapper: (Map<String, Object?> row) => AuthorInfoEntity(
            id: row['id'] as int?,
            authorId: row['authorId'] as int?,
            name: row['name'] as String?,
            image: row['image'] as String?,
            info: row['info'] as String?,
            rating: row['rating'] as double?,
            genres: _listStringConverter.decode(row['genres'] as String?),
            authorBooks:
                _authorBooksConverter.decode(row['authorBooks'] as String?)),
        arguments: [id]);
  }

  @override
  Future<void> insertAuthorInfo(AuthorInfoEntity authorInfoEntity) async {
    await _authorInfoEntityInsertionAdapter.insert(
        authorInfoEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateAuthorInfoById(AuthorInfoEntity authorInfoEntity) async {
    await _authorInfoEntityUpdateAdapter.update(
        authorInfoEntity, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _listStringConverter = ListStringConverter();
final _authorBooksConverter = AuthorBooksConverter();
