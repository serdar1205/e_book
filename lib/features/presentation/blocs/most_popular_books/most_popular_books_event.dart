part of 'most_popular_books_bloc.dart';

@immutable
abstract class MostPopularBooksEvent {}
class GetMostPopularBooks extends MostPopularBooksEvent{

  GetMostPopularBooks();
}
