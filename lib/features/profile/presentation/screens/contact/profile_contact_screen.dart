import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:edu_apply/core/common/widgets/details_info_item.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/core/utils/widget_inserter.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';
import 'package:edu_apply/features/profile/presentation/screens/contact/contact_information_edit_sheet.dart';

class ProfileContactScreen extends StatelessWidget {
  const ProfileContactScreen({super.key});

  void _onContactPress(BuildContext context, Profile profile) {
    showBarModalBottomSheet(
      context: context,
      builder: (context) => ContactInformationEditSheet(
        email: profile.email,
        phone: profile.phone,
        residenceCountry: profile.residenceCountry,
        residenceCity: profile.residenceCity,
        residenceAddress: profile.address,
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
                  onPressed: () => _onContactPress(context, state.profile),
                  label: Text("Edit"),
                  icon: Icon(Icons.edit),
                ),
              ),
            ),
          ],
          appBar: AppBar(
            title: Text("Contact"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              children: widgetInserter(
                children: [
                  DetailsInfoItem(
                    title: "Email",
                    data: profile.email,
                  ),
                  DetailsInfoItem(
                    title: "Phone number",
                    data: profile.phone,
                  ),
                  DetailsInfoItem(
                    title: "Country",
                    data: profile.residenceCountry?.countryName,
                  ),
                  DetailsInfoItem(
                    title: "City",
                    data: profile.residenceCity,
                  ),
                  DetailsInfoItem(
                    title: "Address",
                    data: profile.address,
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
