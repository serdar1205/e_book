part of 'book_details_bloc.dart';

@immutable
abstract class BookDetailsState extends Equatable {}

class BookDetailsLoading extends BookDetailsState {
  BookDetailsLoading();

  @override
  List<Object> get props => [];
}

class BookDetailsLoaded extends BookDetailsState {
  final BookDetailEntity bookDetailEntity;

  BookDetailsLoaded(this.bookDetailEntity);

  @override
  List<Object> get props => [bookDetailEntity];
}

class BookDetailsError extends BookDetailsState {
  final String error;

  BookDetailsError(this.error);

  @override
  List<Object> get props => [error];
}

