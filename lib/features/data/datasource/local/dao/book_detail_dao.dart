import 'package:e_book/features/domain/entity/entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class BookDetailDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertBookDetail(BookDetailEntity bookDetailEntity);

  @Query('SELECT * FROM book_detail WHERE bookId = :id')
  Future<BookDetailEntity?> getBookDetailById(int id);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateBookDetail(BookDetailEntity bookDetailEntity);

}
