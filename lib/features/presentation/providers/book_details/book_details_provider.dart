import 'dart:async';

import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/book_detail_entity.dart';
import 'package:e_book/features/domain/usecases/get_book_detail_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';


part 'book_details_state.dart';

class BookDetailsProvider extends ChangeNotifier {
  GetBookDetailsUseCase useCase;

  BookDetailsState _state = BookDetailsLoading();

  BookDetailsState get state => _state;

  BookDetailsProvider(this.useCase);

  Future<void> getBookDetailsById(int bookId) async {
    try {
      _setLoading();
      final result = await useCase.execute(bookId);

      result.fold((failure) {
        if (failure is ServerFailure) {
          _setError(FailureMessageConstants.serverFailureMessage);
        } else if (failure is ConnectionFailure) {
          _setError(FailureMessageConstants.connectionFailureMessage);
        } else {
          _setError(failure.toString());
        }
      }, (data) {
        _setLoaded(data);
        //  add(GetBookDetails(bookId));
      });
    } catch (e) {
      _setError(e.toString());
    }
  }

  void _setLoading() {
    _state = BookDetailsLoading();
    notifyListeners();
  }

  void _setLoaded(BookDetailEntity data) {
    _state = BookDetailsLoaded(data);
    notifyListeners();
  }

  void _setError(String errorMessage) {
    _state = BookDetailsError(errorMessage);
    notifyListeners();
  }
}
