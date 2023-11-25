import 'package:e_book/core/networks/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  late NetworkInfoImpl networkInfoImpl;

  setUp(() async {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test("should forward the call to InternetConnectionChecker.hasConnection",
        () async {
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);
      //act
      networkInfoImpl.isConnected;
      //assert
      verify(mockInternetConnectionChecker.hasConnection);
    });
  });
}
