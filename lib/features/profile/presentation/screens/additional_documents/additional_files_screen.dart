import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:edu_apply/core/common/entities/additional_document.dart';
import 'package:edu_apply/core/common/widgets/details_info_item.dart';
import 'package:edu_apply/core/common/widgets/styled_loading_indicator.dart';
import 'package:edu_apply/core/common/widgets/styled_no_data_widget.dart';
import 'package:edu_apply/core/common/widgets/styled_option_dialog.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/core/utils/string_extensions.dart';
import 'package:edu_apply/core/utils/widget_inserter.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';
import 'package:edu_apply/features/profile/presentation/screens/additional_documents/add_files_sheet.dart';
import 'package:edu_apply/features/profile/presentation/widgets/additional_document_list_tile.dart';

class AdditionalFilesScreen extends StatelessWidget {
  const AdditionalFilesScreen({super.key});

  void _onDeleteFileTap(
      BuildContext context, AdditionalDocument additionalDocument) async {
    bool response = await showDialog(
          context: context,
          builder: (context) => StyledOptionDialog(
            content:
                'Are you sure you want to delete file${additionalDocument.file?.url.fileName != null ? (" ${additionalDocument.file!.url.fileName}?") : "?"}',
          ),
        ) ??
        false;

    if (response && context.mounted) {
      context.read<ProfileBloc>().add(
            ProfileDeleteDocument(
              id: additionalDocument.id,
            ),
          );
    }
  }

  void _addDocumentPress(BuildContext context) {
    showBarModalBottomSheet(
      context: context,
      builder: (context) => AddFilesSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (BuildContext context, ProfileState state) {
        if (state is ProfileUpdateFailure) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        Profile profile = state.profile;
        return Scaffold(
          appBar: AppBar(
            title: Text("Additional files"),
          ),
          persistentFooterButtons: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ElevatedButton.icon(
                  onPressed: () => _addDocumentPress(context),
                  label: Text("Add"),
                  icon: Icon(Icons.file_copy_outlined),
                ),
              ),
            ),
          ],
          body: profile.additionalDocuments.isEmpty
              ? StyledScrollableNoDataWidget(
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_copy_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Text(
                        "No documents have been added yet",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : state is ProfileUpdateLoading
                  ? Center(child: StyledLoadingIndicator())
                  : ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      children: widgetInserter(
                        children: List.generate(
                          profile.additionalDocuments.length,
                          (index) {
                            AdditionalDocument additionalDocument =
                                profile.additionalDocuments[index];
                            return AdditionalDocumentListTile(
                              additionalDocument: additionalDocument,
                              onDeletePress: (value) =>
                                  _onDeleteFileTap(context, additionalDocument),
                            );
                          },
                        ),
                        separator: Divider(
                          thickness: 1,
                          height: kDividerHeight,
                        ),
                      ).toList(),
                    ),
        );
      },
    );
  }
}
