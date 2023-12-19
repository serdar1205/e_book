part of 'author_info_provider.dart';

abstract class AuthorInfoState extends Equatable with ChangeNotifier {
  AuthorInfoState();

  @override
  List<Object> get props => [];
}

class AuthorInfoLoading extends AuthorInfoState {
  AuthorInfoLoading();

  @override
  List<Object> get props => [];
}

class AuthorInfoLoaded extends AuthorInfoState {
  final AuthorInfoEntity authorInfoEntity;

  AuthorInfoLoaded(this.authorInfoEntity);

  @override
  List<Object> get props => [authorInfoEntity];
}

class AuthorInfoError extends AuthorInfoState {
  final String error;

  AuthorInfoError(this.error);

  @override
  List<Object> get props => [error];
}

class AuthorInfoEmpty extends AuthorInfoState {
  AuthorInfoEmpty();

  @override
  List<Object> get props => [];
}
