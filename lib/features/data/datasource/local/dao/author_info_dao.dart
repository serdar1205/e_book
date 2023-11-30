import 'package:e_book/features/domain/entity/entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class AuthorInfoDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAuthorInfo(AuthorInfoEntity authorInfoEntity);

  @Query('SELECT * FROM author_info WHERE authorId = :id')
  Future<AuthorInfoEntity?> getAuthorInfoById(int id);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateAuthorInfoById(AuthorInfoEntity authorInfoEntity);

}
