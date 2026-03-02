import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_apply/features/application/domain/entities/comment.dart';
import 'package:edu_apply/features/application/domain/use_cases/add_comment.dart';
import 'package:edu_apply/features/application/domain/use_cases/get_comments.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit({
    required AddComment addComment,
    required GetComments getComments,
  })  : _addComment = addComment,
        _getComments = getComments,
        super(CommentsInitial(comments: []));

  final AddComment _addComment;
  final GetComments _getComments;

  void addComment({
    required String text,
    required String applicationId,
  }) async {
    emit(CommentsLoading(comments: [...state.comments]));

    var result = await _addComment.call(
      AddCommentParams(
        text: text,
        applicationId: applicationId,
      ),
    );

    result.fold(
      (l) => emit(
          CommentsFailure(comments: [...state.comments], message: l.message)),
      (r) => emit(CommentsSuccess(comments: [...state.comments, r])),
    );
  }

  void fetchComments({
    required String applicationId,
  }) async {
    emit(CommentsLoading(comments: [...state.comments]));

    var result = await _getComments.call(
      GetCommentsParams(
        applicationId: applicationId,
      ),
    );

    result.fold(
      (l) => emit(
          CommentsFailure(comments: [...state.comments], message: l.message)),
      (r) => emit(CommentsSuccess(comments: [...r])),
    );
  }
}
