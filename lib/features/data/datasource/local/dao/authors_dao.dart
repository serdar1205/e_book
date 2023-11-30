import 'package:e_book/features/domain/entity/entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class AuthorsDao {
  @Insert()
  Future<void> insertAuthors(List<MostPopularAuthorsEntity> authorsEntity);

  @delete
  Future<void> deleteAuthors(List<MostPopularAuthorsEntity> authorsEntity);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateAuthors(List<MostPopularAuthorsEntity> authorsEntity);
  @Query('SELECT * FROM authors')
  Future<List<MostPopularAuthorsEntity>> getAuthors();

  @Query('SELECT COUNT(*) FROM authors')
  Future<int?> getAuthorsCount();
}
