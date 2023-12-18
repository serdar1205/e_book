import 'dart:async';
import 'package:e_book/core/constants/api.dart';
import 'package:e_book/core/errors/failures.dart';
import 'package:e_book/features/domain/entity/author_info_entity.dart';
import 'package:e_book/features/domain/usecases/get_author_info_usecasae.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'author_info_state.dart';

class AuthorInfoProvider extends ChangeNotifier {
  GetAuthorInfoUseCase useCase;
  AuthorInfoState _state = AuthorInfoLoading();

  AuthorInfoState get state => _state;

  AuthorInfoProvider(this.useCase);

  Future<void> getAuthorInfoById(int authorId) async {
    try {
      _setLoading();

      final result = await useCase.execute(authorId);

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
    _state = AuthorInfoLoading();
    notifyListeners();
  }



  void _setLoaded(AuthorInfoEntity data) {
    _state = AuthorInfoLoaded(data);
    notifyListeners();
  }

  void _setError(String errorMessage) {
    _state = AuthorInfoError(errorMessage);
    notifyListeners();
  }

  void _setEmpty() {
    _state = AuthorInfoEmpty();
    notifyListeners();
  }
}
