import 'dart:async';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/weekly_popular_books_entity.dart';
import 'package:e_book/features/domain/usecases/get_weekly_popular_books_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'weekly_popular_books_state.dart';

class WeeklyPopularBooksProvider extends ChangeNotifier {
  GetWeeklyPopularBooksUseCase useCase;

  WeeklyPopularBooksState _state = const WeeklyPopularBooksLoading();

  WeeklyPopularBooksState get state => _state;

  WeeklyPopularBooksProvider({required this.useCase});

  Future<void> getWeeklyPopularBooks() async {
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
    _state = const WeeklyPopularBooksLoading();
    notifyListeners();
  }

  void _setLoaded(List<WeeklyPopularBooksEntity> data) {
    _state = WeeklyPopularBooksLoaded(data);
    notifyListeners();
  }

  void _setError(String errorMessage) {
    _state = WeeklyPopularBooksError(errorMessage);
    notifyListeners();
  }

  void _setEmpty() {
    _state = const WeeklyPopularBooksEmpty();
    notifyListeners();
  }
}
