import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:edu_apply/core/common/widgets/details_info_item.dart';
import 'package:edu_apply/core/utils/date_time_extensions.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/core/utils/string_extensions.dart';
import 'package:edu_apply/core/utils/widget_inserter.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';
import 'package:edu_apply/features/profile/presentation/screens/language_certificate/language_proficiency_information_edit_sheet.dart';

class ProfileLanguageCertificateScreen extends StatelessWidget {
  const ProfileLanguageCertificateScreen({super.key});

  void _onLanguageProficiencyInfoEditPress(
      BuildContext context, Profile profile) {
    showBarModalBottomSheet(
      context: context,
      builder: (context) => LanguageProficiencyInformationEditSheet(
        language: profile.englishProficiencyExam?.language,
        grade: profile.englishProficiencyExam?.grade,
        dateOfExam: profile.englishProficiencyExam?.dateOfExam,
        certificate: profile.englishProficiencyExam?.certificate,
      ),
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
          persistentFooterButtons: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ElevatedButton.icon(
                  onPressed: () => _onLanguageProficiencyInfoEditPress(
                      context, state.profile),
                  label: Text("Edit"),
                  icon: Icon(Icons.edit),
                ),
              ),
            ),
          ],
          appBar: AppBar(
            title: Text("Language certificate"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
                children: widgetInserter(
              children: [
                DetailsInfoItem(
                  title: "Exam",
                  data: profile.englishProficiencyExam?.language,
                ),
                DetailsInfoItem(
                  title: "Score",
                  data: profile.englishProficiencyExam?.grade,
                ),
                DetailsInfoItem(
                  title: "Exam date",
                  data: profile.englishProficiencyExam?.dateOfExam?.appFormat,
                ),
                DetailsInfoItem(
                  title: "Certificate",
                  data: profile
                      .englishProficiencyExam?.certificate?.file?.url.fileName,
                ),
              ],
              separator: Divider(
                thickness: 1,
                height: kDividerHeight,
              ),
            ).toList()),
          ),
        );
      },
    );
  }
}
