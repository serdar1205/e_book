import 'package:e_book/features/domain/entity/entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class AwardedBooksDao {
  @Insert()
  Future<void> insertAwardedBooks(List<AwardedBooksEntity> awardedBooksEntity);

  @delete
  Future<void> deleteAwardedBooks(List<AwardedBooksEntity> awardedBooksEntity);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateAwardedBooks(List<AwardedBooksEntity> awardedBooksEntity);
  @Query('SELECT * FROM awarded_books')
  Future<List<AwardedBooksEntity>> getAwardedBooks();

  @Query('SELECT COUNT(*) FROM awarded_books')
  Future<int?> getAwardedBooksCount();
}
