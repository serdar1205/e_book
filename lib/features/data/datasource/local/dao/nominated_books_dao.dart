import 'package:e_book/features/domain/entity/entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class NominatedBooksDao {
  @Insert()
  Future<void> insertNominatedBooks(List<NominatedBooksEntity> nominatedBooksEntity);

  @delete
  Future<void> deleteNominatedBooks(List<NominatedBooksEntity> nominatedBooksEntity);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateNominatedBooks(List<NominatedBooksEntity> nominatedBooksEntity);
  @Query('SELECT * FROM nominated_books')
  Future<List<NominatedBooksEntity>> getNominatedBooks();

  @Query('SELECT COUNT(*) FROM nominated_books')
  Future<int?> getNominatedBooksCount();
}
