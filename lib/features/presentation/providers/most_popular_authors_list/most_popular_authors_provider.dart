import 'dart:async';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/most_popular_authors_entity.dart';
import 'package:e_book/features/domain/usecases/get_most_popular_authors_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'most_popular_authors_state.dart';

class MostPopularAuthorsProvider extends ChangeNotifier {
  GetMostPopularAuthorsUseCase allAuthorsUsecase;

  MostPopularAuthorsListState _state = MostPopularAuthorsListLoading();

  MostPopularAuthorsListState get state => _state;

  MostPopularAuthorsProvider({required this.allAuthorsUsecase});

  Future<void> getAllAuthorsEvent() async {
    try {
      _setLoading();
      final result = await allAuthorsUsecase.execute();

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
    _state = MostPopularAuthorsListLoading();
    notifyListeners();
  }

  void _setLoaded(List<MostPopularAuthorsEntity> data) {
    _state = MostPopularAuthorsListLoaded(data);
    notifyListeners();
  }

  void _setError(String errorMessage) {
    _state = MostPopularAuthorsListError(errorMessage);
    notifyListeners();
  }

  void _setEmpty() {
    _state = MostPopularAuthorsListEmpty();
    notifyListeners();
  }
}
