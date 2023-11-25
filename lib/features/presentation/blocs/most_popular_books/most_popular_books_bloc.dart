import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/most_popular_books_entity.dart';
import 'package:e_book/features/domain/usecases/get_most_popular_books_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'most_popular_books_event.dart';

part 'most_popular_books_state.dart';

class MostPopularBooksBloc extends Bloc<MostPopularBooksEvent, MostPopularBooksState> {
  GetMostPopularBooksUseCase useCase;

  MostPopularBooksBloc(this.useCase) : super(const MostPopularBooksLoading()) {
    on<GetMostPopularBooks>(getMostPopularBooks);
  }

  Future<void> getMostPopularBooks(
      GetMostPopularBooks event, Emitter<MostPopularBooksState> emit) async {
    emit(const MostPopularBooksLoading());
    try {

      final result = await useCase.execute();

      result.fold((failure) {
        if (failure is ServerFailure) {
          emit(const MostPopularBooksError(
              FailureMessageConstants.serverFailureMessage));
        } else if (failure is ConnectionFailure) {
          emit(const MostPopularBooksError(
              FailureMessageConstants.connectionFailureMessage));
        } else {
          emit(MostPopularBooksError(failure.toString()));
        }
      }, (data) {
        emit(MostPopularBooksLoaded(data));
        if (data.isEmpty) {
          emit(const MostPopularBooksEmpty());
        }
      });
    } catch (e) {
      emit(MostPopularBooksError(e.toString()));
    }
  }
}
