part of 'author_info_bloc.dart';

@immutable
abstract class AuthorInfoEvent {}

class GetAuthorInfo extends AuthorInfoEvent {
final int authorId;
  GetAuthorInfo(this.authorId);
}
