import 'package:e_book/features/domain/entity/entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class MostPopularBooksDao {
  @Insert()
  Future<void> insertMostPopularBooks(List<MostPopularBooksEntity> mostPopularBooksEntity);

  @delete
  Future<void> deleteMostPopularBooks(List<MostPopularBooksEntity> mostPopularBooksEntity);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateMostPopularBooks(List<MostPopularBooksEntity> mostPopularBooksEntity);
  @Query('SELECT * FROM most_popular_books')
  Future<List<MostPopularBooksEntity>> getMostPopularBooks();

  @Query('SELECT COUNT(*) FROM most_popular_books')
  Future<int?> getMostPopularBooksCount();
}
