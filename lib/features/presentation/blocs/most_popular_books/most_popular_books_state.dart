part of 'most_popular_books_bloc.dart';

@immutable
abstract class MostPopularBooksState extends Equatable {
  const MostPopularBooksState();

  @override
  List<Object> get props => [];
}

class MostPopularBooksLoading extends MostPopularBooksState {
  const MostPopularBooksLoading();

  @override
  List<Object> get props => [];
}

class MostPopularBooksLoaded extends MostPopularBooksState {
  final List<MostPopularBooksEntity> mostPopularBooksEntity;

  const MostPopularBooksLoaded(this.mostPopularBooksEntity);

  @override
  List<Object> get props => [mostPopularBooksEntity];
}

class MostPopularBooksError extends MostPopularBooksState {
  final String error;

  const MostPopularBooksError(this.error);

  @override
  List<Object> get props => [error];
}

class MostPopularBooksEmpty extends MostPopularBooksState {
  const MostPopularBooksEmpty();

  @override
  List<Object> get props => [];
}
