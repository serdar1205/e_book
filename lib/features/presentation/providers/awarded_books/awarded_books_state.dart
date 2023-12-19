part of 'awarded_books_provider.dart';

@immutable
abstract class AwardedBooksState extends Equatable {

  const AwardedBooksState();

  @override
  List<Object> get props => [];
}

class AwardedBooksLoading extends AwardedBooksState {}

class AwardedBooksLoaded extends AwardedBooksState {
  final List<AwardedBooksEntity> awardedBooksEntity;

  const AwardedBooksLoaded(this.awardedBooksEntity);

  @override
  List<Object> get props => [awardedBooksEntity];
}

class AwardedBooksEmpty extends AwardedBooksState {

  const AwardedBooksEmpty();

  @override
  List<Object> get props => [];
}

class AwardedBooksError extends AwardedBooksState {
  final String error;

  const AwardedBooksError(this.error);

  @override
  List<Object> get props => [error];
}
