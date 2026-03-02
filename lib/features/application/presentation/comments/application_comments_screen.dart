import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_apply/core/utils/date_time_extensions.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/features/application/domain/entities/comment.dart';
import 'package:edu_apply/features/application/presentation/comments/comments_cubit/comments_cubit.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';

class ApplicationCommentsScreen extends StatefulWidget {
  const ApplicationCommentsScreen({
    super.key,
    required String applicationId,
  }) : _applicationId = applicationId;

  final String _applicationId;

  @override
  State<ApplicationCommentsScreen> createState() =>
      _ApplicationCommentsScreenState();
}

class _ApplicationCommentsScreenState extends State<ApplicationCommentsScreen> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  void _onSentPress() {
    if (_textController.text.trim().isEmpty) return;
    context.read<CommentsCubit>().addComment(
          text: _textController.text,
          applicationId: widget._applicationId,
        );
    _textController.clear();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<CommentsCubit>()
        .fetchComments(applicationId: widget._applicationId);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Comments"),
          centerTitle: false,
        ),
        body: BlocConsumer<CommentsCubit, CommentsState>(
          listener: (context, state) {
            if (state is CommentsFailure) {
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            List<Comment> comments = state.comments;
            return SafeArea(
              bottom: true,
              top: false,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      children: List.generate(
                        comments.length,
                        (index) {
                          bool isUserMessage =
                              context.read<ProfileBloc>().state.profile.id ==
                                  comments[index].createdBy;
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Align(
                              alignment: isUserMessage
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: isUserMessage
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  if (isUserMessage) ...[
                                    Flexible(
                                      child: Text(
                                        comments[index].updatedAt.appLogTime,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(fontSize: 10),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                  ],
                                  Flexible(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                        color: isUserMessage
                                            ? Color(0xFFF8F8F8)
                                            : Theme.of(context)
                                                .colorScheme
                                                .secondaryContainer,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      child: Text(
                                        comments[index].text.trim(),
                                      ),
                                    ),
                                  ),
                                  if (!isUserMessage) ...[
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                      child: Text(
                                        comments[index].updatedAt.appLogTime,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(fontSize: 10),
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: <Widget>[
                        // Text input field
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            decoration: InputDecoration(
                              hintText: 'Type a message...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        // Send button
                        IconButton(
                          icon: Icon(Icons.send, color: Colors.blueAccent),
                          onPressed: _onSentPress,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
