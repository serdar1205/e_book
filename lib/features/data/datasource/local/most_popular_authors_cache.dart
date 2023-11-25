import 'package:e_book/features/domain/entity/entity.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class MostPopularAuthorsCache {
  late Box<MostPopularAuthorsEntity> _authorsBox;

  Future<void> initHive() async {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentsDirectory.path);

    Hive.registerAdapter(MostPopularAuthorsEntityAdapter());

    _authorsBox = await Hive.openBox<MostPopularAuthorsEntity>(
        'most_popular_authors_box');
  }

  Future<List<MostPopularAuthorsEntity>> getCachedData() async {
    try {
      if (!_authorsBox.isOpen) {
        await initHive();
      }
      return _authorsBox.values.toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cacheData(List<MostPopularAuthorsEntity> data) async {
    try {
      await _authorsBox.clear();
      await _authorsBox.addAll(data);
    } catch (e) {
      // Handle errors appropriately
      rethrow;
    }
  }
}
