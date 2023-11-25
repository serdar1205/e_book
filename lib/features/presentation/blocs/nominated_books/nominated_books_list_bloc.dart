import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'package:e_book/core/constants/constants.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/nominated_books_entity.dart';
import 'package:e_book/features/domain/usecases/get_nominated_books_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'nominated_books_list_event.dart';

part 'nominated_books_list_state.dart';

class NominatedBooksListBloc
    extends Bloc<NominatedBooksListEvent, NominatedBooksListState> {
  GetNominatedBooksUseCase useCase;

  NominatedBooksListBloc({required this.useCase})
      : super(const NominatedBooksListLoadingState()) {
    on<GetNominatedBooksListEvent>(getNominatedBooksListEvent);
  }

  Future<void> getNominatedBooksListEvent(GetNominatedBooksListEvent event,
      Emitter<NominatedBooksListState> emit) async {
    emit(const NominatedBooksListLoadingState());
    try {

      final result = await useCase.execute();

      result.fold((failure) {
        if (failure is ServerFailure) {
          emit(const NominatedBooksListErrorState(
              FailureMessageConstants.serverFailureMessage));
        } else if (failure is ConnectionFailure) {
          emit(const NominatedBooksListErrorState(
              FailureMessageConstants.connectionFailureMessage));
        } else {
          emit(NominatedBooksListErrorState(failure.toString()));
        }
      }, (data) {
        emit(NominatedBooksListLoadedState(data));
        if (data.isEmpty) {
          emit(const NominatedBooksListEmptyState());
        }
      });
    } catch (e) {
      emit(NominatedBooksListErrorState(e.toString()));
    }
  }
}
