import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/book_detail_entity.dart';
import 'package:e_book/features/domain/usecases/get_book_detail_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'book_details_event.dart';

part 'book_details_state.dart';

class BookDetailsBloc extends Bloc<BookDetailsEvent, BookDetailsState> {
  GetBookDetailsUseCase useCase;

  BookDetailsBloc(this.useCase) : super(BookDetailsLoading()) {
    on<GetBookDetails>(getBookDetailsById);
  }

  Future<void> getBookDetailsById(
      GetBookDetails event, Emitter<BookDetailsState> emit) async {
    emit(BookDetailsLoading());
    try {
      final int bookId = event.bookId;
      final result = await useCase.execute(bookId);

      result.fold((failure) {
        if (failure is ServerFailure) {
          emit(BookDetailsError(FailureMessageConstants.serverFailureMessage));
        } else if (failure is ConnectionFailure) {
          emit(BookDetailsError(
              FailureMessageConstants.connectionFailureMessage));
        } else {
          emit(BookDetailsError(failure.toString()));
        }
      }, (data) {
        emit(BookDetailsLoaded(data));
      //  add(GetBookDetails(bookId));
      });
    } catch (e) {
      emit(BookDetailsError(e.toString()));
    }
  }
}
