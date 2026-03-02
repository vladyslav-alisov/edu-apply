import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:edu_apply/core/common/widgets/details_info_item.dart';
import 'package:edu_apply/core/common/widgets/labeled_widget.dart';
import 'package:edu_apply/core/common/widgets/styled_container.dart';
import 'package:edu_apply/core/common/widgets/styled_file_picker.dart';
import 'package:edu_apply/core/common/widgets/styled_option_dialog.dart';
import 'package:edu_apply/core/const/enums/application_status.dart';
import 'package:edu_apply/core/router/app_routes.dart';
import 'package:edu_apply/core/theme/color_scheme.dart';
import 'package:edu_apply/core/utils/date_time_extensions.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/core/utils/string_extensions.dart';
import 'package:edu_apply/core/utils/widget_inserter.dart';
import 'package:edu_apply/features/application/domain/entities/application.dart';
import 'package:edu_apply/features/application/presentation/application/application_bloc/application_bloc.dart';
import 'package:edu_apply/features/application/presentation/files/documents_bloc/documents_cubit.dart';
import 'package:edu_apply/features/program/presentation/widgets/information_container.dart';

class ApplicationDetailsScreen extends StatelessWidget {
  const ApplicationDetailsScreen({
    super.key,
    required Application application,
  }) : _application = application;

  final Application _application;

  void _onSeeLogsPress(BuildContext context) {
    context.push(
      AppRoutes.applicationLogs.path,
      extra: _application.id,
    );
  }

  void _onSeeFilesPress(BuildContext context) {
    context.push(
      AppRoutes.applicationFiles.path,
      extra: _application.id,
    );
  }

  void _onSeeCommentsPress(BuildContext context) {
    context.push(
      AppRoutes.applicationComments.path,
      extra: _application.id,
    );
  }

  void _onIPaidDepositPress(BuildContext context) async {
    File? file = await showBarModalBottomSheet<File?>(
      context: context,
      builder: (context) => DepositPaymentSheet(),
    );
    if (file != null && context.mounted) {
      context.read<DocumentsCubit>().addDocument(
            name: "Deposit",
            file: file,
            applicationId: _application.id,
          );
    }
  }

  void _onDeletePress(BuildContext context) async {
    bool response = await showDialog(
          context: context,
          builder: (context) => StyledOptionDialog(
            content:
                "Are you sure you want to permanently delete this application?",
          ),
        ) ??
        false;

    if (response && context.mounted) {
      context.read<ApplicationBloc>().add(
            ApplicationDelete(
              application: _application,
            ),
          );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DocumentsCubit, DocumentsState>(
      listener: (context, state) {
        if (state is DocumentsAddedSuccess) {
          showSnackBar(context,
              "Your deposit receipt has been uploaded successfully! The status of your application will be updated once an authorized user reviews your receipt.");
        }
      },
      child: Scaffold(
        persistentFooterButtons: _application.status ==
                ApplicationStatus.offerSent
            ? [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _onIPaidDepositPress(context),
                      child: Text(
                        "I Paid Deposit",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ]
            : null,
        appBar: AppBar(
          title: Text("Application"),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _application.degreeType?.getTitle(context) ?? "",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  _application.universityProgramName ?? "",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  _application.universityName ?? "",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            Gap(16),
            StyledContainer(
              color: _application.status.bgColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 14,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _application.status.getTitle(context),
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: _application.status.textColor,
                                ),
                      ),
                      Text(
                        "${_application.status.stepsLeft} steps left",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  Gap(8),
                  LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(20),
                    value: _application.status.progressPercentage,
                    color: _application.status.textColor,
                    minHeight: 14,
                  ),
                ],
              ),
            ),
            Gap(16),
            InformationContainer(
              title: "Progress",
              children: widgetInserter(
                children: [
                  DetailsInfoItem(
                    title: "Approved",
                    data: _application.approved ? "Approved" : "Not approved",
                    iconData: Icons.school_outlined,
                    dataTextStyle: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(
                          color:
                              _application.approved ? Colors.green : Colors.red,
                        ),
                  ),
                  DetailsInfoItem(
                    title: "Applied",
                    data: _application.applied ? "Applied" : "Not applied",
                    iconData: Icons.settings_applications,
                    dataTextStyle: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(
                          color:
                              _application.applied ? Colors.green : Colors.red,
                        ),
                  ),
                  DetailsInfoItem(
                    title: "Authorized user",
                    data: _application.workerName,
                    iconData: Icons.language_outlined,
                  ),
                ],
                separator: Divider(
                  height: 30,
                  thickness: 1,
                ),
              ).toList(),
            ),
            Gap(16),
            InformationContainer(
              title: "Details",
              children: widgetInserter(
                children: [
                  DetailsInfoItem(
                    title: "Season",
                    data: _application.programStartMonth?.appSeasonFormat,
                    iconData: Icons.school_outlined,
                  ),
                  DetailsInfoItem(
                    title: "Education language",
                    data: _application.educationLanguage.capitalize,
                    iconData: Icons.language_outlined,
                  ),
                  DetailsInfoItem(
                    title: "Application platform",
                    data: _application.source?.json,
                    iconData: Icons.timer_outlined,
                  ),
                  DetailsInfoItem(
                    title: "Code",
                    data: _application.code,
                    iconData: Icons.ac_unit_outlined,
                  ),
                  DetailsInfoItem(
                    title: "Education type",
                    data: _application.campusType?.getTitle(context),
                    iconData: Icons.watch_later_outlined,
                  ),
                ],
                separator: Divider(
                  height: 30,
                  thickness: 1,
                ),
              ).toList(),
            ),
            Gap(16),
            InformationContainer(
              title: "Price",
              children: widgetInserter(
                children: [
                  DetailsInfoItem(
                    title: "Paid",
                    data: _application.tuitionCurrency
                        .showWithNumber(_application.amountPaid),
                    iconData: Icons.school_outlined,
                    iconColor: kMoneyIconColor,
                  ),
                  DetailsInfoItem(
                    title: "Total",
                    data: _application.tuitionCurrency
                        .showWithNumber(_application.tuitionFee),
                    iconData: Icons.language_outlined,
                    iconColor: kMoneyIconColor,
                  ),
                ],
                separator: Divider(
                  height: 30,
                  thickness: 1,
                ),
              ).toList(),
            ),
            Gap(16),
            ButtonTextContainer(
              title: "Logs",
              buttonTitle: "See logs",
              onPressed: () => _onSeeLogsPress(context),
              iconData: Icons.menu,
            ),
            Gap(16),
            ButtonTextContainer(
              title: "Files",
              buttonTitle: "See files",
              onPressed: () => _onSeeFilesPress(context),
              iconData: Icons.file_copy_outlined,
            ),
            Gap(16),
            ButtonTextContainer(
              title: "Commands",
              buttonTitle: "Talk with authorized user",
              onPressed: () => _onSeeCommentsPress(context),
              iconData: Icons.comment_outlined,
            ),
            Gap(16),
            GestureDetector(
              onTap: () => _onDeletePress(context),
              child: StyledContainer(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delete application",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                    Icon(
                      Icons.delete_outline,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonTextContainer extends StatelessWidget {
  const ButtonTextContainer({
    super.key,
    void Function()? onPressed,
    required String title,
    required String buttonTitle,
    required IconData iconData,
  })  : _buttonTitle = buttonTitle,
        _title = title,
        _onPressed = onPressed,
        _iconData = iconData;

  final VoidCallback? _onPressed;
  final String _title;
  final String _buttonTitle;
  final IconData _iconData;

  @override
  Widget build(BuildContext context) {
    return StyledContainer(
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                _iconData,
                color: Theme.of(context).primaryColor,
              ),
              Gap(4),
              Text(
                _title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          Divider(
            thickness: 1,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _onPressed,
              child: Text(
                _buttonTitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DepositPaymentSheet extends StatelessWidget {
  const DepositPaymentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    File? currentFile;

    return Scaffold(
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.pop(currentFile),
              child: Text(
                "Submit",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...widgetInserter(
              children: [
                LabeledWidget(
                  label: 'Document name',
                  child: TextFormField(
                    initialValue: "Deposit receipt",
                    readOnly: true,
                  ),
                ),
                LabeledWidget(
                  label: 'File',
                  child: StyledFilePicker(
                    onFilePicked: (value) {
                      currentFile = value;
                    },
                    onFileInitialized: (value) {},
                    onFileDeleted: () {
                      currentFile = null;
                    },
                  ),
                ),
              ],
              separator: Gap(16),
            ),
          ],
        ),
      ),
    );
  }
}
