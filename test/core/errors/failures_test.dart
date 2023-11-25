import 'package:e_book/core/errors/errors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testProps = [];

  group("Failures", () {
    test('make sure the props value is [errorMessage]', () async {
      expect(ServerFailure().properties, testProps);
    });
  });
}
