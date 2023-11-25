part of 'nominated_books_list_bloc.dart';

@immutable
abstract class NominatedBooksListEvent {}

class GetNominatedBooksListEvent extends NominatedBooksListEvent{

  GetNominatedBooksListEvent();
}