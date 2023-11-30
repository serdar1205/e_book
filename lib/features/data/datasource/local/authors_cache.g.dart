// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authors_cache.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAuthorsCache {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AuthorsCacheBuilder databaseBuilder(String name) =>
      _$AuthorsCacheBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AuthorsCacheBuilder inMemoryDatabaseBuilder() =>
      _$AuthorsCacheBuilder(null);
}

class _$AuthorsCacheBuilder {
  _$AuthorsCacheBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AuthorsCacheBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AuthorsCacheBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AuthorsCache> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AuthorsCache();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AuthorsCache extends AuthorsCache {
  _$AuthorsCache([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AuthorsDao? _authorsDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `authors` (`id` INTEGER, `authorId` INTEGER, `name` TEXT, `image` TEXT, `url` TEXT, `popularBookTitle` TEXT, `popularBookUrl` TEXT, `numberPublishedBooks` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AuthorsDao get authorsDao {
    return _authorsDaoInstance ??= _$AuthorsDao(database, changeListener);
  }
}

class _$AuthorsDao extends AuthorsDao {
  _$AuthorsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _mostPopularAuthorsEntityInsertionAdapter = InsertionAdapter(
            database,
            'authors',
            (MostPopularAuthorsEntity item) => <String, Object?>{
                  'id': item.id,
                  'authorId': item.authorId,
                  'name': item.name,
                  'image': item.image,
                  'url': item.url,
                  'popularBookTitle': item.popularBookTitle,
                  'popularBookUrl': item.popularBookUrl,
                  'numberPublishedBooks': item.numberPublishedBooks
                }),
        _mostPopularAuthorsEntityUpdateAdapter = UpdateAdapter(
            database,
            'authors',
            ['id'],
            (MostPopularAuthorsEntity item) => <String, Object?>{
                  'id': item.id,
                  'authorId': item.authorId,
                  'name': item.name,
                  'image': item.image,
                  'url': item.url,
                  'popularBookTitle': item.popularBookTitle,
                  'popularBookUrl': item.popularBookUrl,
                  'numberPublishedBooks': item.numberPublishedBooks
                }),
        _mostPopularAuthorsEntityDeletionAdapter = DeletionAdapter(
            database,
            'authors',
            ['id'],
            (MostPopularAuthorsEntity item) => <String, Object?>{
                  'id': item.id,
                  'authorId': item.authorId,
                  'name': item.name,
                  'image': item.image,
                  'url': item.url,
                  'popularBookTitle': item.popularBookTitle,
                  'popularBookUrl': item.popularBookUrl,
                  'numberPublishedBooks': item.numberPublishedBooks
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MostPopularAuthorsEntity>
      _mostPopularAuthorsEntityInsertionAdapter;

  final UpdateAdapter<MostPopularAuthorsEntity>
      _mostPopularAuthorsEntityUpdateAdapter;

  final DeletionAdapter<MostPopularAuthorsEntity>
      _mostPopularAuthorsEntityDeletionAdapter;

  @override
  Future<List<MostPopularAuthorsEntity>> getAuthors() async {
    return _queryAdapter.queryList('SELECT * FROM authors',
        mapper: (Map<String, Object?> row) => MostPopularAuthorsEntity(
            id: row['id'] as int?,
            authorId: row['authorId'] as int?,
            name: row['name'] as String?,
            url: row['url'] as String?,
            image: row['image'] as String?,
            popularBookTitle: row['popularBookTitle'] as String?,
            popularBookUrl: row['popularBookUrl'] as String?,
            numberPublishedBooks: row['numberPublishedBooks'] as int?));
  }

  @override
  Future<int?> getAuthorsCount() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM authors',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertAuthors(
      List<MostPopularAuthorsEntity> authorsEntity) async {
    await _mostPopularAuthorsEntityInsertionAdapter.insertList(
        authorsEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateAuthors(
      List<MostPopularAuthorsEntity> authorsEntity) async {
    await _mostPopularAuthorsEntityUpdateAdapter.updateList(
        authorsEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteAuthors(
      List<MostPopularAuthorsEntity> authorsEntity) async {
    await _mostPopularAuthorsEntityDeletionAdapter.deleteList(authorsEntity);
  }
}
