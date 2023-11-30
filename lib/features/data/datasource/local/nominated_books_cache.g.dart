// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nominated_books_cache.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorNominatedBooksCache {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NominatedBooksCacheBuilder databaseBuilder(String name) =>
      _$NominatedBooksCacheBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NominatedBooksCacheBuilder inMemoryDatabaseBuilder() =>
      _$NominatedBooksCacheBuilder(null);
}

class _$NominatedBooksCacheBuilder {
  _$NominatedBooksCacheBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$NominatedBooksCacheBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$NominatedBooksCacheBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<NominatedBooksCache> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$NominatedBooksCache();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$NominatedBooksCache extends NominatedBooksCache {
  _$NominatedBooksCache([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NominatedBooksDao? _nominatedBooksDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `nominated_books` (`id` INTEGER, `bookId` INTEGER, `bookName` TEXT, `author` TEXT, `votes` INTEGER, `image` TEXT, `url` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NominatedBooksDao get nominatedBooksDao {
    return _nominatedBooksDaoInstance ??=
        _$NominatedBooksDao(database, changeListener);
  }
}

class _$NominatedBooksDao extends NominatedBooksDao {
  _$NominatedBooksDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _nominatedBooksEntityInsertionAdapter = InsertionAdapter(
            database,
            'nominated_books',
            (NominatedBooksEntity item) => <String, Object?>{
                  'id': item.id,
                  'bookId': item.bookId,
                  'bookName': item.bookName,
                  'author': item.author,
                  'votes': item.votes,
                  'image': item.image,
                  'url': item.url
                }),
        _nominatedBooksEntityUpdateAdapter = UpdateAdapter(
            database,
            'nominated_books',
            ['id'],
            (NominatedBooksEntity item) => <String, Object?>{
                  'id': item.id,
                  'bookId': item.bookId,
                  'bookName': item.bookName,
                  'author': item.author,
                  'votes': item.votes,
                  'image': item.image,
                  'url': item.url
                }),
        _nominatedBooksEntityDeletionAdapter = DeletionAdapter(
            database,
            'nominated_books',
            ['id'],
            (NominatedBooksEntity item) => <String, Object?>{
                  'id': item.id,
                  'bookId': item.bookId,
                  'bookName': item.bookName,
                  'author': item.author,
                  'votes': item.votes,
                  'image': item.image,
                  'url': item.url
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NominatedBooksEntity>
      _nominatedBooksEntityInsertionAdapter;

  final UpdateAdapter<NominatedBooksEntity> _nominatedBooksEntityUpdateAdapter;

  final DeletionAdapter<NominatedBooksEntity>
      _nominatedBooksEntityDeletionAdapter;

  @override
  Future<List<NominatedBooksEntity>> getNominatedBooks() async {
    return _queryAdapter.queryList('SELECT * FROM nominated_books',
        mapper: (Map<String, Object?> row) => NominatedBooksEntity(
            id: row['id'] as int?,
            bookId: row['bookId'] as int?,
            bookName: row['bookName'] as String?,
            url: row['url'] as String?,
            author: row['author'] as String?,
            votes: row['votes'] as int?,
            image: row['image'] as String?));
  }

  @override
  Future<int?> getNominatedBooksCount() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM nominated_books',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertNominatedBooks(
      List<NominatedBooksEntity> nominatedBooksEntity) async {
    await _nominatedBooksEntityInsertionAdapter.insertList(
        nominatedBooksEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateNominatedBooks(
      List<NominatedBooksEntity> nominatedBooksEntity) async {
    await _nominatedBooksEntityUpdateAdapter.updateList(
        nominatedBooksEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteNominatedBooks(
      List<NominatedBooksEntity> nominatedBooksEntity) async {
    await _nominatedBooksEntityDeletionAdapter.deleteList(nominatedBooksEntity);
  }
}
