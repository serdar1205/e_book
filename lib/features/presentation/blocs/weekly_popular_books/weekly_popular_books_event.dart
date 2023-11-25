part of 'weekly_popular_books_bloc.dart';

@immutable
abstract class WeeklyPopularBooksEvent {}

class GetWeeklyPopularBooksEvent extends WeeklyPopularBooksEvent {
  GetWeeklyPopularBooksEvent();
}
