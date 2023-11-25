part of 'most_popular_authors_bloc.dart';

abstract class MostPopularAuthorsListState extends Equatable {
  const MostPopularAuthorsListState();

  @override
  List<Object> get props => [];
}

class MostPopularAuthorsListLoading extends MostPopularAuthorsListState {}



class MostPopularAuthorsListLoaded extends MostPopularAuthorsListState {
  final List<MostPopularAuthorsEntity> authors;

  const MostPopularAuthorsListLoaded(this.authors);

  @override
  List<Object> get props => [authors];
}
class MostPopularAuthorsListEmpty extends MostPopularAuthorsListState {}
class MostPopularAuthorsListError extends MostPopularAuthorsListState {
  final String message;

  const MostPopularAuthorsListError(this.message);

  @override
  List<Object> get props => [message];
}
