// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'most_popular_books_cache.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorMostPopularBooksCache {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MostPopularBooksCacheBuilder databaseBuilder(String name) =>
      _$MostPopularBooksCacheBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MostPopularBooksCacheBuilder inMemoryDatabaseBuilder() =>
      _$MostPopularBooksCacheBuilder(null);
}

class _$MostPopularBooksCacheBuilder {
  _$MostPopularBooksCacheBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$MostPopularBooksCacheBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$MostPopularBooksCacheBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<MostPopularBooksCache> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$MostPopularBooksCache();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$MostPopularBooksCache extends MostPopularBooksCache {
  _$MostPopularBooksCache([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MostPopularBooksDao? _mostPopularBooksDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `most_popular_books` (`id` INTEGER, `bookId` INTEGER, `name` TEXT, `image` TEXT, `rating` REAL, `url` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MostPopularBooksDao get mostPopularBooksDao {
    return _mostPopularBooksDaoInstance ??=
        _$MostPopularBooksDao(database, changeListener);
  }
}

class _$MostPopularBooksDao extends MostPopularBooksDao {
  _$MostPopularBooksDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _mostPopularBooksEntityInsertionAdapter = InsertionAdapter(
            database,
            'most_popular_books',
            (MostPopularBooksEntity item) => <String, Object?>{
                  'id': item.id,
                  'bookId': item.bookId,
                  'name': item.name,
                  'image': item.image,
                  'rating': item.rating,
                  'url': item.url
                }),
        _mostPopularBooksEntityUpdateAdapter = UpdateAdapter(
            database,
            'most_popular_books',
            ['id'],
            (MostPopularBooksEntity item) => <String, Object?>{
                  'id': item.id,
                  'bookId': item.bookId,
                  'name': item.name,
                  'image': item.image,
                  'rating': item.rating,
                  'url': item.url
                }),
        _mostPopularBooksEntityDeletionAdapter = DeletionAdapter(
            database,
            'most_popular_books',
            ['id'],
            (MostPopularBooksEntity item) => <String, Object?>{
                  'id': item.id,
                  'bookId': item.bookId,
                  'name': item.name,
                  'image': item.image,
                  'rating': item.rating,
                  'url': item.url
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MostPopularBooksEntity>
      _mostPopularBooksEntityInsertionAdapter;

  final UpdateAdapter<MostPopularBooksEntity>
      _mostPopularBooksEntityUpdateAdapter;

  final DeletionAdapter<MostPopularBooksEntity>
      _mostPopularBooksEntityDeletionAdapter;

  @override
  Future<List<MostPopularBooksEntity>> getMostPopularBooks() async {
    return _queryAdapter.queryList('SELECT * FROM most_popular_books',
        mapper: (Map<String, Object?> row) => MostPopularBooksEntity(
            id: row['id'] as int?,
            bookId: row['bookId'] as int?,
            name: row['name'] as String?,
            image: row['image'] as String?,
            url: row['url'] as String?,
            rating: row['rating'] as double?));
  }

  @override
  Future<int?> getMostPopularBooksCount() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM most_popular_books',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertMostPopularBooks(
      List<MostPopularBooksEntity> mostPopularBooksEntity) async {
    await _mostPopularBooksEntityInsertionAdapter.insertList(
        mostPopularBooksEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMostPopularBooks(
      List<MostPopularBooksEntity> mostPopularBooksEntity) async {
    await _mostPopularBooksEntityUpdateAdapter.updateList(
        mostPopularBooksEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteMostPopularBooks(
      List<MostPopularBooksEntity> mostPopularBooksEntity) async {
    await _mostPopularBooksEntityDeletionAdapter
        .deleteList(mostPopularBooksEntity);
  }
}
