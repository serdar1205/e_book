import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/author_info_entity.dart';
import 'package:e_book/features/domain/usecases/get_author_info_usecasae.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'author_info_event.dart';

part 'author_info_state.dart';

class AuthorInfoBloc extends Bloc<AuthorInfoEvent, AuthorInfoState> {
  GetAuthorInfoUseCase useCase;

  AuthorInfoBloc(this.useCase) : super(const AuthorInfoLoading()) {
    on<GetAuthorInfo>(getAuthorInfoById);
  }

  Future<void> getAuthorInfoById(
      GetAuthorInfo event, Emitter<AuthorInfoState> emit) async {
    emit(const AuthorInfoLoading());
    try {
      final int authorId = event.authorId;
      final result = await useCase.execute(authorId);

      result.fold((failure) {
        if (failure is ServerFailure) {
          emit(const AuthorInfoError(
              FailureMessageConstants.serverFailureMessage));
        } else if (failure is ConnectionFailure) {
          emit(const AuthorInfoError(
              FailureMessageConstants.connectionFailureMessage));
        } else {
          emit(AuthorInfoError(failure.toString()));
        }
      }, (data) {
        emit(AuthorInfoLoaded(data));
      });
    } catch (e) {
      emit(AuthorInfoError(e.toString()));
    }
  }
}
