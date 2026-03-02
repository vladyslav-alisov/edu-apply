part of 'comments_cubit.dart';

@immutable
sealed class CommentsState {
  final List<Comment> comments;

  const CommentsState({required this.comments});
}

final class CommentsInitial extends CommentsState {
  const CommentsInitial({required super.comments});
}

final class CommentsLoading extends CommentsState {
  const CommentsLoading({required super.comments});
}

final class CommentsFailure extends CommentsState {
  final String message;
  const CommentsFailure({required super.comments, required this.message});
}

final class CommentsSuccess extends CommentsState {
  const CommentsSuccess({required super.comments});
}
