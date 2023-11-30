// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'awarded_books_cache.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAwardedBooksCache {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AwardedBooksCacheBuilder databaseBuilder(String name) =>
      _$AwardedBooksCacheBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AwardedBooksCacheBuilder inMemoryDatabaseBuilder() =>
      _$AwardedBooksCacheBuilder(null);
}

class _$AwardedBooksCacheBuilder {
  _$AwardedBooksCacheBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AwardedBooksCacheBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AwardedBooksCacheBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AwardedBooksCache> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AwardedBooksCache();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AwardedBooksCache extends AwardedBooksCache {
  _$AwardedBooksCache([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AwardedBooksDao? _awardedBooksDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `awarded_books` (`id` INTEGER, `bookId` INTEGER, `name` TEXT, `image` TEXT, `url` TEXT, `winningCategory` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AwardedBooksDao get awardedBooksDao {
    return _awardedBooksDaoInstance ??=
        _$AwardedBooksDao(database, changeListener);
  }
}

class _$AwardedBooksDao extends AwardedBooksDao {
  _$AwardedBooksDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _awardedBooksEntityInsertionAdapter = InsertionAdapter(
            database,
            'awarded_books',
            (AwardedBooksEntity item) => <String, Object?>{
                  'id': item.id,
                  'bookId': item.bookId,
                  'name': item.name,
                  'image': item.image,
                  'url': item.url,
                  'winningCategory': item.winningCategory
                }),
        _awardedBooksEntityUpdateAdapter = UpdateAdapter(
            database,
            'awarded_books',
            ['id'],
            (AwardedBooksEntity item) => <String, Object?>{
                  'id': item.id,
                  'bookId': item.bookId,
                  'name': item.name,
                  'image': item.image,
                  'url': item.url,
                  'winningCategory': item.winningCategory
                }),
        _awardedBooksEntityDeletionAdapter = DeletionAdapter(
            database,
            'awarded_books',
            ['id'],
            (AwardedBooksEntity item) => <String, Object?>{
                  'id': item.id,
                  'bookId': item.bookId,
                  'name': item.name,
                  'image': item.image,
                  'url': item.url,
                  'winningCategory': item.winningCategory
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AwardedBooksEntity>
      _awardedBooksEntityInsertionAdapter;

  final UpdateAdapter<AwardedBooksEntity> _awardedBooksEntityUpdateAdapter;

  final DeletionAdapter<AwardedBooksEntity> _awardedBooksEntityDeletionAdapter;

  @override
  Future<List<AwardedBooksEntity>> getAwardedBooks() async {
    return _queryAdapter.queryList('SELECT * FROM awarded_books',
        mapper: (Map<String, Object?> row) => AwardedBooksEntity(
            id: row['id'] as int?,
            bookId: row['bookId'] as int?,
            name: row['name'] as String?,
            winningCategory: row['winningCategory'] as String?,
            image: row['image'] as String?,
            url: row['url'] as String?));
  }

  @override
  Future<int?> getAwardedBooksCount() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM awarded_books',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertAwardedBooks(
      List<AwardedBooksEntity> awardedBooksEntity) async {
    await _awardedBooksEntityInsertionAdapter.insertList(
        awardedBooksEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateAwardedBooks(
      List<AwardedBooksEntity> awardedBooksEntity) async {
    await _awardedBooksEntityUpdateAdapter.updateList(
        awardedBooksEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteAwardedBooks(
      List<AwardedBooksEntity> awardedBooksEntity) async {
    await _awardedBooksEntityDeletionAdapter.deleteList(awardedBooksEntity);
  }
}
