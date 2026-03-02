import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:edu_apply/core/common/widgets/details_info_item.dart';
import 'package:edu_apply/core/common/widgets/items_found_text.dart';
import 'package:edu_apply/core/common/widgets/styled_loading_indicator.dart';
import 'package:edu_apply/core/utils/date_time_extensions.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/core/utils/widget_inserter.dart';
import 'package:edu_apply/features/application/domain/entities/log.dart';
import 'package:edu_apply/features/application/presentation/logs/logs_bloc/logs_bloc.dart';
import 'package:edu_apply/features/application/presentation/widgets/step_information_widget.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';
import 'package:edu_apply/features/program/presentation/widgets/information_container.dart';

const double kIconRadius = 25;
const double kDividerLength = 116;

class ApplicationLogsScreen extends StatelessWidget {
  const ApplicationLogsScreen({super.key, required String applicationId})
      : _applicationId = applicationId;

  final String _applicationId;

  void _onDetailsPress(BuildContext context, Log log) {
    showBarModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InformationContainer(
                  title: "Log details",
                  children: widgetInserter(
                    children: [
                      DetailsInfoItem(
                        title: "Addition date",
                        data: log.updatedAt.appLogDateTime,
                      ),
                      DetailsInfoItem(
                        title: "From",
                        data: log.creatorName,
                      ),
                      DetailsInfoItem(
                        title: "Note",
                        data: log.message,
                      ),
                    ],
                    separator: Divider(
                      height: 30,
                      thickness: 1,
                    ),
                  ).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<LogsBloc>().add(
          LogsFetch(applicationId: _applicationId),
        );

    return Scaffold(
      appBar: AppBar(
        title: Text("Logs"),
      ),
      body: BlocConsumer<LogsBloc, LogsOverviewState>(
        listener: (context, state) {
          if (state.status == LogsOverviewStatus.failure) {
            showSnackBar(context, "Something went wrong");
          }
        },
        builder: (context, state) {
          if (state.status == LogsOverviewStatus.loading) {
            return Center(
              child: StyledLoadingIndicator(),
            );
          }

          return ListView(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            children: [
              Text(
                "Follow your application process easily and see the details when updated.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Gap(16),
              ItemsFoundText(
                title: "Logs found:",
                totalElements: state.logs.length,
                iconData: Icons.menu,
              ),
              Gap(4),
              Divider(
                thickness: 1,
              ),
              Gap(4),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: List.generate(
                        state.logs.length,
                        (index) {
                          Log log = state.logs[index];
                          bool isUserCreatedAction = log.createdBy ==
                              context.read<ProfileBloc>().state.profile.id;

                          return SizedBox(
                            height: 2 * kIconRadius + kDividerLength,
                            child: isUserCreatedAction
                                ? null
                                : StepInformationWidget(
                                    title: log.status.getTitle(context),
                                    date: log.updatedAt,
                                    isUserAction: isUserCreatedAction,
                                    onStepPress: () =>
                                        _onDetailsPress(context, log),
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(
                        state.logs.length,
                        (index) {
                          Log log = state.logs[index];
                          bool isLastIndex = state.logs.length == index + 1;
                          bool hasOneItem = state.logs.length == 1;
                          return Column(
                            children: [
                              CircleAvatar(
                                radius: kIconRadius,
                                backgroundColor: Theme.of(context).primaryColor,

                                ///log.status.textColor,
                                child: Icon(
                                  log.status.iconData,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: kDividerLength,
                                child: isLastIndex || hasOneItem
                                    ? null
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: VerticalDivider(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline,
                                          thickness: 1,
                                        ),
                                      ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(
                        state.logs.length,
                        (index) {
                          Log log = state.logs[index];
                          bool isUserCreatedAction = log.createdBy ==
                              context.read<ProfileBloc>().state.profile.id;
                          return SizedBox(
                            height: 2 * kIconRadius + kDividerLength,
                            child: isUserCreatedAction
                                ? StepInformationWidget(
                                    title: log.status.getTitle(context),
                                    date: log.updatedAt,
                                    isUserAction: isUserCreatedAction,
                                    onStepPress: () =>
                                        _onDetailsPress(context, log),
                                  )
                                : null,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
