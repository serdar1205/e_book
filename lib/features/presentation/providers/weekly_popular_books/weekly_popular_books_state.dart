part of 'weekly_popular_books_provider.dart';

@immutable
abstract class WeeklyPopularBooksState extends Equatable {
  const WeeklyPopularBooksState();

  @override
  List<Object> get props => [];
}

class WeeklyPopularBooksLoading extends WeeklyPopularBooksState {
  const WeeklyPopularBooksLoading();

  @override
  List<Object> get props => [];
}

class WeeklyPopularBooksLoaded extends WeeklyPopularBooksState {
  final List<WeeklyPopularBooksEntity> weeklyPopularBooksEntity;

  const WeeklyPopularBooksLoaded(this.weeklyPopularBooksEntity);

  @override
  List<Object> get props => [weeklyPopularBooksEntity];
}

class WeeklyPopularBooksError extends WeeklyPopularBooksState {
  final String error;

  const WeeklyPopularBooksError(this.error);

  @override
  List<Object> get props => [error];
}

class WeeklyPopularBooksEmpty extends WeeklyPopularBooksState {
  const WeeklyPopularBooksEmpty();

  @override
  List<Object> get props => [];
}
