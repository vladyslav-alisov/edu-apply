import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:edu_apply/core/common/entities/additional_document.dart';
import 'package:edu_apply/core/common/widgets/details_info_item.dart';
import 'package:edu_apply/core/common/widgets/items_found_text.dart';
import 'package:edu_apply/core/common/widgets/styled_download_button.dart';
import 'package:edu_apply/core/common/widgets/styled_loading_indicator.dart';
import 'package:edu_apply/core/utils/date_time_extensions.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/core/utils/widget_inserter.dart';
import 'package:edu_apply/features/application/presentation/files/documents_bloc/documents_cubit.dart';
import 'package:edu_apply/features/program/presentation/widgets/information_container.dart';

const double kIconRadius = 25;
const double kDividerLength = 116;

class ApplicationFilesScreen extends StatelessWidget {
  const ApplicationFilesScreen({super.key, required String applicationId})
      : _applicationId = applicationId;

  final String _applicationId;

  @override
  Widget build(BuildContext context) {
    bool isDownloading = false;
    context
        .read<DocumentsCubit>()
        .fetchDocuments(applicationId: _applicationId);
    return Scaffold(
      appBar: AppBar(
        title: Text("Files"),
      ),
      body: BlocConsumer<DocumentsCubit, DocumentsState>(
        listener: (context, state) {
          if (state is DocumentsFailure) {
            showSnackBar(context, "Something went wrong");
          }
        },
        builder: (context, state) {
          if (state is DocumentsLoading) {
            return Center(
              child: StyledLoadingIndicator(),
            );
          }
          List<AdditionalDocument> documents = state.documents;
          return ListView(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            children: [
              Text(
                "Access all documents that shared by you and authorized person.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Gap(16),
              ItemsFoundText(
                title: "Files found:",
                totalElements: documents.length,
                iconData: Icons.menu,
              ),
              Gap(4),
              Divider(
                thickness: 1,
              ),
              Gap(4),
              ...widgetInserter(
                children: List.generate(
                  documents.length,
                  (index) {
                    AdditionalDocument doc = documents[index];
                    return InformationContainer(
                      title: "${doc.name}",
                      titleTrailing: StyledDownloadIcon(
                        fileUrl: doc.file?.url,
                        onIsDownloadingStatusChange: (value) =>
                            isDownloading = value,
                      ),
                      children: [
                        DetailsInfoItem(
                          title: "File name",
                          data: doc.name,
                          iconData: Icons.title,
                        ),
                        DetailsInfoItem(
                          title: "Addition date",
                          data: doc.updatedAt?.appLogDateTime,
                          iconData: Icons.date_range,
                        ),
                      ],
                    );
                  },
                ),
                separator: Gap(
                  16,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
