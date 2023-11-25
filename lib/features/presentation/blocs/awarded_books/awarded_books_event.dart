part of 'awarded_books_bloc.dart';

@immutable
abstract class AwardedBooksEvent {}

class GetAwardedBooksEvent extends AwardedBooksEvent{

  GetAwardedBooksEvent();
}
