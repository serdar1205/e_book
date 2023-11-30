import 'package:e_book/features/domain/entity/entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class WeeklyPopularBooksDao {
  @Insert()
  Future<void> insertWeeklyPopularBooks(List<WeeklyPopularBooksEntity> weeklyPopularBooksEntity);

  @delete
  Future<void> deleteWeeklyPopularBooks(List<WeeklyPopularBooksEntity> weeklyPopularBooksEntity);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateWeeklyPopularBooks(List<WeeklyPopularBooksEntity> weeklyPopularBooksEntity);

  @Query('SELECT * FROM weekly_popular_books')
  Future<List<WeeklyPopularBooksEntity>> getWeeklyPopularBooks();

  @Query('SELECT COUNT(*) FROM weekly_popular_books')
  Future<int?> getWeeklyPopularBooksCount();
}
