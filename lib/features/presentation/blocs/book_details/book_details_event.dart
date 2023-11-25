part of 'book_details_bloc.dart';

@immutable
abstract class BookDetailsEvent {}

class GetBookDetails extends BookDetailsEvent {
  final int bookId;

  GetBookDetails(this.bookId);
}
