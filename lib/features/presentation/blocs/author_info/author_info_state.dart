part of 'author_info_bloc.dart';

@immutable
abstract class AuthorInfoState extends Equatable {
  const AuthorInfoState();

  @override
  List<Object> get props => [];
}

class AuthorInfoLoading extends AuthorInfoState {
  const AuthorInfoLoading();

  @override
  List<Object> get props => [];
}

class AuthorInfoLoaded extends AuthorInfoState {
  final AuthorInfoEntity authorInfoEntity;

  const AuthorInfoLoaded(this.authorInfoEntity);

  @override
  List<Object> get props => [authorInfoEntity];
}

class AuthorInfoError extends AuthorInfoState {
  final String error;

  const AuthorInfoError(this.error);

  @override
  List<Object> get props => [error];
}

class AuthorInfoEmpty extends AuthorInfoState {
  const AuthorInfoEmpty();

  @override
  List<Object> get props => [];
}
