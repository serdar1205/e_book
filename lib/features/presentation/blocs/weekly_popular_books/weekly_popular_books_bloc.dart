import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/weekly_popular_books_entity.dart';
import 'package:e_book/features/domain/usecases/get_weekly_popular_books_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'weekly_popular_books_event.dart';

part 'weekly_popular_books_state.dart';

class WeeklyPopularBooksBloc
    extends Bloc<WeeklyPopularBooksEvent, WeeklyPopularBooksState> {
  GetWeeklyPopularBooksUseCase useCase;

  WeeklyPopularBooksBloc({required this.useCase})
      : super(const WeeklyPopularBooksLoading()) {
    on<GetWeeklyPopularBooksEvent>(getWeeklyPopularBooks);
  }

  Future<void> getWeeklyPopularBooks(GetWeeklyPopularBooksEvent event,
      Emitter<WeeklyPopularBooksState> emit) async {
    emit(const WeeklyPopularBooksLoading());
    try {

      final result = await useCase.execute();

      result.fold((failure) {
        if (failure is ServerFailure) {
          emit(const WeeklyPopularBooksError(
              FailureMessageConstants.serverFailureMessage));
        } else if (failure is ConnectionFailure) {
          emit(const WeeklyPopularBooksError(
              FailureMessageConstants.connectionFailureMessage));
        } else {
          emit(WeeklyPopularBooksError(failure.toString()));
        }
      }, (data) {
        emit(WeeklyPopularBooksLoaded(data));
        if (data.isEmpty) {
          emit(const WeeklyPopularBooksEmpty());
        }
      });
    } catch (e) {
      emit(WeeklyPopularBooksError(e.toString()));
    }
  }
}
