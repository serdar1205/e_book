part of 'nominated_books_list_provider.dart';

@immutable
abstract class NominatedBooksListState extends Equatable {
  const NominatedBooksListState();

  @override
  List<Object> get props => [];
}

class NominatedBooksListLoadingState extends NominatedBooksListState {
  const NominatedBooksListLoadingState();

  @override
  List<Object> get props => [];
}

class NominatedBooksListLoadedState extends NominatedBooksListState {
  final List<NominatedBooksEntity> nominatedBooks;

  const NominatedBooksListLoadedState(this.nominatedBooks);

  @override
  List<Object> get props => [nominatedBooks];
}

class NominatedBooksListEmptyState extends NominatedBooksListState {
  const NominatedBooksListEmptyState();

  @override
  List<Object> get props => [];
}

class NominatedBooksListErrorState extends NominatedBooksListState {
  final String error;

  const NominatedBooksListErrorState(this.error);

  @override
  List<Object> get props => [error];
}
