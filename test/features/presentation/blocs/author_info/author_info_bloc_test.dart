import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/errors.dart';
import 'package:e_book/features/data/model/author_info_model.dart';
import 'package:e_book/features/presentation/blocs/author_info/author_info_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../helper/test_helper.mocks.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  late AuthorInfoBloc authorInfoBloc;
  late MockGetAuthorInfoUseCase useCase;

  setUp(() {
    useCase = MockGetAuthorInfoUseCase();
    authorInfoBloc = AuthorInfoBloc(useCase);
  });

  final testJson = fixtureReader("author_info.json");
  final testModel = AuthorInfoModel.fromMap(json.decode(testJson));
  final authorId = testModel.authorId;

  test('initial state should be AuthorInfoLoading', () async {
    //assert
    expect(authorInfoBloc.state, const AuthorInfoLoading());
  });

  group('getAuthorInfoById event', () {
    blocTest<AuthorInfoBloc, AuthorInfoState>(
        'should emit [AuthorInfoLoading , AuthorInfoLoaded]',
        build: () {
          when(useCase.execute(any))
              .thenAnswer((realInvocation) async => Right(testModel));
          return authorInfoBloc;
        },
        act: (bloc) => bloc.add(GetAuthorInfo(authorId!)),
        expect: () => [
              const AuthorInfoLoading(),
              AuthorInfoLoaded(testModel),
            ],
        verify: (bloc) {
          verify(useCase.execute(authorId));
        });

    blocTest(
        'should emit [AuthorInfoLoading, AuthorInfoError] when occurred ServerFailure error',
        build: () {
          when(useCase.execute(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          return authorInfoBloc;
        },
        act: (bloc) => bloc.add(GetAuthorInfo(authorId!)),
        expect: () => [
              const AuthorInfoLoading(),
              const AuthorInfoError(
                  FailureMessageConstants.serverFailureMessage)
            ],
        verify: (bloc) {
          verify(useCase.execute(authorId));
        });
    blocTest(
        'should emit [AuthorInfoLoading, AuthorInfoError] when occurred ConnectionFailure error',
        build: () {
          when(useCase.execute(any))
              .thenAnswer((_) async => Left(ConnectionFailure()));
          return authorInfoBloc;
        },
        act: (bloc) => bloc.add(GetAuthorInfo(authorId!)),
        expect: () => [
              const AuthorInfoLoading(),
              const AuthorInfoError(
                  FailureMessageConstants.connectionFailureMessage),
            ],
        verify: (bloc) {
          verify(useCase.execute(authorId));
        });

     blocTest('should emit [AuthorInfoLoading, AuthorInfoError] when data is unsuccessful',
         build: (){
       when(useCase.execute(any))
           .thenThrow('Something went wrong');
           return authorInfoBloc;
         },
        act: (bloc)=>bloc.add(GetAuthorInfo(authorId!)),
       expect: ()=>[
         const AuthorInfoLoading(),
         const AuthorInfoError('Something went wrong'),
       ] ,
       verify: (bloc){
       verify(useCase.execute(authorId));
       }

     );



  });
}
