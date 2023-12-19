import 'dart:async';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/most_popular_books_entity.dart';
import 'package:e_book/features/domain/usecases/get_most_popular_books_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'most_popular_books_state.dart';

class MostPopularBooksProvider extends ChangeNotifier {
  GetMostPopularBooksUseCase useCase;
  MostPopularBooksState _state = const MostPopularBooksLoading();

  MostPopularBooksState get state => _state;

  MostPopularBooksProvider(this.useCase);

  Future<void> getMostPopularBooks() async {
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
          print(data);
        } else {
          _setEmpty();
        }
      });
    } catch (e) {
      _setError(e.toString());
    }
  }

  void _setLoading() {
    _state = const MostPopularBooksLoading();
    notifyListeners();
  }

  void _setLoaded(List<MostPopularBooksEntity> data) {
    _state = MostPopularBooksLoaded(data);
    notifyListeners();
  }

  void _setError(String errorMessage) {
    _state = MostPopularBooksError(errorMessage);
    notifyListeners();
  }

  void _setEmpty() {
    _state = const MostPopularBooksEmpty();
    notifyListeners();
  }
}
