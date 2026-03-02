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
import 'package:edu_apply/features/profile/presentation/screens/passport/passport_information_edit_sheet.dart';

class PassportInformationScreen extends StatelessWidget {
  const PassportInformationScreen({super.key});

  void _onPassportInfoEditPress(BuildContext context, Profile profile) {
    showBarModalBottomSheet(
      context: context,
      builder: (context) => PassportInformationEditSheet(
        passportNumber: profile.passport?.passportNumber,
        dateOfIssue: profile.passport?.dateOfIssue,
        dateOfExpire: profile.passport?.dateOfExpire,
        passport: profile.passport?.file,
        nationality: profile.nationality,
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
                      _onPassportInfoEditPress(context, state.profile),
                  label: Text("Edit"),
                  icon: Icon(Icons.edit),
                ),
              ),
            ),
          ],
          appBar: AppBar(
            title: Text("Passport"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              children: widgetInserter(
                children: [
                  DetailsInfoItem(
                    title: "Nationality",
                    data: profile.nationality?.countryName,
                  ),
                  DetailsInfoItem(
                    title: "Passport number",
                    data: profile.passport?.passportNumber,
                  ),
                  DetailsInfoItem(
                    title: "Date of issue",
                    data: profile.passport?.dateOfIssue != null
                        ? profile.passport?.dateOfIssue!.appFormat
                        : profile.passport?.dateOfIssue,
                  ),
                  DetailsInfoItem(
                    title: "Date of expiry",
                    data: profile.passport?.dateOfExpire != null
                        ? profile.passport?.dateOfExpire!.appFormat
                        : profile.passport?.dateOfExpire,
                  ),
                  DetailsInfoItem(
                    title: "Passport",
                    data: profile.passport?.file?.file?.url.fileName,
                  ),
                ],
                separator: Divider(
                  thickness: 1,
                  height: kDividerHeight,
                ),
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}
