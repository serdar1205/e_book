import 'dart:async';
import 'package:e_book/core/constants/constants.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/nominated_books_entity.dart';
import 'package:e_book/features/domain/usecases/get_nominated_books_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
part 'nominated_books_list_state.dart';

class NominatedBooksListProvider extends ChangeNotifier {
  GetNominatedBooksUseCase useCase;

  NominatedBooksListState _state = const NominatedBooksListLoadingState();

  NominatedBooksListState get state => _state;

  NominatedBooksListProvider({required this.useCase});

  Future<void> getNominatedBooksListEvent() async {
    try {
      _setLoading();
      final result = await useCase.execute();

      result.fold((failure) {
        if (failure is ServerFailure) {
          _setError(FailureMessageConstants.serverFailureMessage);
        } else if (failure is ConnectionFailure) {
          _setError(FailureMessageConstants.connectionFailureMessage);
        } else {
          _setError(failure.toString());
        }
      }, (data) {
        if (data.isNotEmpty) {
          _setLoaded(data);
        } else {
          _setEmpty();
        }
      });
    } catch (e) {
      _setError(e.toString());
    }
  }

  void _setLoading() {
    _state = const NominatedBooksListLoadingState();
    notifyListeners();
  }

  void _setLoaded(List<NominatedBooksEntity> data) {
    _state = NominatedBooksListLoadedState(data);
    notifyListeners();
  }

  void _setError(String errorMessage) {
    _state = NominatedBooksListErrorState(errorMessage);
    notifyListeners();
  }

  void _setEmpty() {
    _state = const NominatedBooksListEmptyState();
    notifyListeners();
  }
}
