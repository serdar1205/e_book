import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/awarded_books_entity.dart';
import 'package:e_book/features/domain/usecases/get_awarded_books_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'awarded_books_event.dart';

part 'awarded_books_state.dart';

class AwardedBooksBloc extends Bloc<AwardedBooksEvent, AwardedBooksState> {
  GetAwardedBooksUseCase useCase;

  AwardedBooksBloc(this.useCase) : super(AwardedBooksLoading()) {
    on<AwardedBooksEvent>(getAwardedBooks);
  }

  Future<void> getAwardedBooks(
      AwardedBooksEvent event, Emitter<AwardedBooksState> emit) async {
    emit(AwardedBooksLoading());
    try {

      final result = await useCase.execute();

      result.fold((failure) {
        if (failure is ServerFailure) {
          emit(const AwardedBooksError(
              FailureMessageConstants.serverFailureMessage));
        } else if (failure is ConnectionFailure) {
          emit(const AwardedBooksError(
              FailureMessageConstants.connectionFailureMessage));
        } else {
          emit(AwardedBooksError(failure.toString()));
          print(failure.toString());
        }
      }, (data) {
        emit(AwardedBooksLoaded(data));
        if (data.isEmpty) {
          emit(const AwardedBooksEmpty());
        }
      });
    } catch (e) {
      emit(AwardedBooksError(e.toString()));
    }
  }
}
