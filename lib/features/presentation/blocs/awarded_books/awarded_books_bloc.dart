import 'dart:async';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/awarded_books_entity.dart';
import 'package:e_book/features/domain/usecases/get_awarded_books_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'awarded_books_state.dart';

class AwardedBooksProvider extends ChangeNotifier {
  GetAwardedBooksUseCase useCase;

  AwardedBooksState _state = AwardedBooksLoading();

  AwardedBooksState get state => _state;

  AwardedBooksProvider(this.useCase);

  Future<void> getAwardedBooks() async {
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
    _state = AwardedBooksLoading();
    notifyListeners();
  }

  void _setLoaded(List<AwardedBooksEntity> data) {
    _state = AwardedBooksLoaded(data);
    notifyListeners();
  }

  void _setError(String errorMessage) {
    _state = AwardedBooksError(errorMessage);
    notifyListeners();
  }

  void _setEmpty() {
    _state = AwardedBooksEmpty();
    notifyListeners();
  }
}
