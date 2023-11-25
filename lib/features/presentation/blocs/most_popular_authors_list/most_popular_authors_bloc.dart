import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/most_popular_authors_entity.dart';
import 'package:e_book/features/domain/usecases/get_most_popular_authors_usecase.dart';
import 'package:equatable/equatable.dart';
part 'most_popular_authors_event.dart';

part 'most_popular_authors_state.dart';

class MostPopularAuthorsListBloc extends Bloc<MostPopularAuthorsListEvent, MostPopularAuthorsListState> {
  GetMostPopularAuthorsUseCase allAuthorsUsecase;

  MostPopularAuthorsListBloc({required this.allAuthorsUsecase}) : super(
      MostPopularAuthorsListLoading()) {
    on<GetMostPopularAuthorsEvent>(getAllAuthorsEvent);
  }

  Future<void> getAllAuthorsEvent(GetMostPopularAuthorsEvent event, Emitter<MostPopularAuthorsListState>  emit)async {
    emit(MostPopularAuthorsListLoading());
    try {

      final result = await allAuthorsUsecase.execute();

      result.fold((failure) {
        if (failure is ServerFailure) {
          emit(const MostPopularAuthorsListError(FailureMessageConstants.serverFailureMessage));
        } else if (failure is ConnectionFailure) {
          emit(const MostPopularAuthorsListError(
              FailureMessageConstants.connectionFailureMessage));
        }
        else{
          emit(MostPopularAuthorsListError(failure.toString()));
        }
      }, (data) {
        emit(MostPopularAuthorsListLoaded(data));
        if (data.isEmpty) {
          emit(MostPopularAuthorsListEmpty());
        }
      });
    } catch (e) {
      emit(MostPopularAuthorsListError(e.toString()));
    }
  }
}

