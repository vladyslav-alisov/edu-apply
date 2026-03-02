import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_apply/core/common/widgets/styled_loading_indicator.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';

class ModelEditScaffold extends StatelessWidget {
  const ModelEditScaffold({
    super.key,
    required this.child,
    required this.title,
    this.onSubmitPress,
  });

  final Widget child;
  final String title;
  final VoidCallback? onSubmitPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        persistentFooterButtons: [
          BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileUpdateSuccess) context.pop();
            },
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: state is ProfileUpdateLoading
                      ? StyledLoadingIndicator()
                      : ElevatedButton(
                          onPressed: onSubmitPress,
                          child: Text("Submit"),
                        ),
                ),
              );
            },
          ),
        ],
        appBar: AppBar(
          title: Text(
            title,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          elevation: 0.2,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          child: child,
        ),
      ),
    );
  }
}
