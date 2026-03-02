import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:edu_apply/core/common/widgets/details_info_item.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/core/utils/string_extensions.dart';
import 'package:edu_apply/core/utils/widget_inserter.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';
import 'package:edu_apply/features/profile/presentation/screens/education/school_information_edit_sheet.dart';

class ProfileEducationScreen extends StatelessWidget {
  const ProfileEducationScreen({super.key});

  void _onSchoolInfoEditPress(BuildContext context, Profile profile) {
    showBarModalBottomSheet(
      context: context,
      builder: (context) => SchoolInformationEditSheet(
        nameOfSchool: profile.educationHistory?.nameOfSchool,
        degreeName: profile.educationHistory?.degreeName,
        countryCode: profile.educationHistory?.countryCode,
        cgpa: profile.educationHistory?.cgpa,
        graduationYear: profile.educationHistory?.graduationYear,
        transcript: profile.educationHistory?.transcript,
        diploma: profile.educationHistory?.diploma,
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
                  onPressed: () =>
                      _onSchoolInfoEditPress(context, state.profile),
                  label: Text("Edit"),
                  icon: Icon(Icons.edit),
                ),
              ),
            ),
          ],
          appBar: AppBar(
            title: Text("Education"),
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                  children: widgetInserter(
                children: [
                  DetailsInfoItem(
                    title: "School name",
                    data: profile.educationHistory?.nameOfSchool,
                  ),
                  DetailsInfoItem(
                    title: "Degree",
                    data: profile.educationHistory?.degreeName,
                  ),
                  DetailsInfoItem(
                    title: "Country",
                    data: profile.educationHistory?.countryCode?.countryName,
                  ),
                  DetailsInfoItem(
                    title: "CGPA",
                    data: profile.educationHistory?.cgpa,
                  ),
                  DetailsInfoItem(
                    title: "Graduate year",
                    data: profile.educationHistory?.graduationYear,
                  ),
                  DetailsInfoItem(
                    title: "Diploma",
                    data: profile.educationHistory?.diploma?.file?.url.fileName,
                  ),
                  DetailsInfoItem(
                    title: "Transcript",
                    data: profile
                        .educationHistory?.transcript?.file?.url.fileName,
                  ),
                ],
                separator: Divider(
                  thickness: 1,
                  height: kDividerHeight,
                ),
              ).toList())),
        );
      },
    );
  }
}
