// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_popular_books_cache.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorWeeklyPopularBooksCache {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$WeeklyPopularBooksCacheBuilder databaseBuilder(String name) =>
      _$WeeklyPopularBooksCacheBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$WeeklyPopularBooksCacheBuilder inMemoryDatabaseBuilder() =>
      _$WeeklyPopularBooksCacheBuilder(null);
}

class _$WeeklyPopularBooksCacheBuilder {
  _$WeeklyPopularBooksCacheBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$WeeklyPopularBooksCacheBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$WeeklyPopularBooksCacheBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<WeeklyPopularBooksCache> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$WeeklyPopularBooksCache();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$WeeklyPopularBooksCache extends WeeklyPopularBooksCache {
  _$WeeklyPopularBooksCache([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  WeeklyPopularBooksDao? _weeklyPopularBooksDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `weekly_popular_books` (`id` INTEGER, `bookId` INTEGER, `name` TEXT, `image` TEXT, `url` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  WeeklyPopularBooksDao get weeklyPopularBooksDao {
    return _weeklyPopularBooksDaoInstance ??=
        _$WeeklyPopularBooksDao(database, changeListener);
  }
}

class _$WeeklyPopularBooksDao extends WeeklyPopularBooksDao {
  _$WeeklyPopularBooksDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _weeklyPopularBooksEntityInsertionAdapter = InsertionAdapter(
            database,
            'weekly_popular_books',
            (WeeklyPopularBooksEntity item) => <String, Object?>{
                  'id': item.id,
                  'bookId': item.bookId,
                  'name': item.name,
                  'image': item.image,
                  'url': item.url
                }),
        _weeklyPopularBooksEntityUpdateAdapter = UpdateAdapter(
            database,
            'weekly_popular_books',
            ['id'],
            (WeeklyPopularBooksEntity item) => <String, Object?>{
                  'id': item.id,
                  'bookId': item.bookId,
                  'name': item.name,
                  'image': item.image,
                  'url': item.url
                }),
        _weeklyPopularBooksEntityDeletionAdapter = DeletionAdapter(
            database,
            'weekly_popular_books',
            ['id'],
            (WeeklyPopularBooksEntity item) => <String, Object?>{
                  'id': item.id,
                  'bookId': item.bookId,
                  'name': item.name,
                  'image': item.image,
                  'url': item.url
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<WeeklyPopularBooksEntity>
      _weeklyPopularBooksEntityInsertionAdapter;

  final UpdateAdapter<WeeklyPopularBooksEntity>
      _weeklyPopularBooksEntityUpdateAdapter;

  final DeletionAdapter<WeeklyPopularBooksEntity>
      _weeklyPopularBooksEntityDeletionAdapter;

  @override
  Future<List<WeeklyPopularBooksEntity>> getWeeklyPopularBooks() async {
    return _queryAdapter.queryList('SELECT * FROM weekly_popular_books',
        mapper: (Map<String, Object?> row) => WeeklyPopularBooksEntity(
            id: row['id'] as int?,
            bookId: row['bookId'] as int?,
            name: row['name'] as String?,
            url: row['url'] as String?,
            image: row['image'] as String?));
  }

  @override
  Future<int?> getWeeklyPopularBooksCount() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM weekly_popular_books',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertWeeklyPopularBooks(
      List<WeeklyPopularBooksEntity> weeklyPopularBooksEntity) async {
    await _weeklyPopularBooksEntityInsertionAdapter.insertList(
        weeklyPopularBooksEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateWeeklyPopularBooks(
      List<WeeklyPopularBooksEntity> weeklyPopularBooksEntity) async {
    await _weeklyPopularBooksEntityUpdateAdapter.updateList(
        weeklyPopularBooksEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteWeeklyPopularBooks(
      List<WeeklyPopularBooksEntity> weeklyPopularBooksEntity) async {
    await _weeklyPopularBooksEntityDeletionAdapter
        .deleteList(weeklyPopularBooksEntity);
  }
}
