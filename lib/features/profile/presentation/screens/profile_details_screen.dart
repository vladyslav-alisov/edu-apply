import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:edu_apply/core/common/widgets/details_info_item.dart';
import 'package:edu_apply/core/common/widgets/styled_cached_network_image.dart';
import 'package:edu_apply/core/common/widgets/styled_loading_indicator.dart';
import 'package:edu_apply/core/utils/date_time_extensions.dart';
import 'package:edu_apply/core/utils/image_picker.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/core/utils/widget_inserter.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';
import 'package:edu_apply/features/profile/presentation/screens/personal_information_edit_sheet.dart';
import 'package:edu_apply/features/profile/presentation/screens/profile_screen.dart';
import 'package:edu_apply/features/program/presentation/widgets/information_container.dart';

const double kImageSize = 128;

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  void _onEditProfileImagePress(BuildContext context) async {
    ImageSourceOption? option = await selectSource(context);
    if (option == null) return;
    File? file = await selectImage(option);
    if (file != null && context.mounted) {
      context.read<ProfileBloc>().add(ProfileUpdateImage(profileImage: file));
    }
  }

  void _onEditProfilePress(BuildContext context, Profile profile) async {
    showBarModalBottomSheet(
      context: context,
      builder: (context) => PersonalInformationEditSheet(
        initBirthdate: profile.birthdate,
        firstName: profile.firstName,
        lastName: profile.lastName,
        gender: profile.sex,
        fatherName: profile.fatherName,
        motherName: profile.motherName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile details"),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (BuildContext context, ProfileState state) {
          if (state is ProfileUpdateFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (!state.isProfileInitialized) {
            return Center(child: Text("Profile is not available"));
          }
          Profile profile = state.profile;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 27),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () => _onEditProfileImagePress(context),
                  child: StyledCachedNetworkImage(
                    imageUrl: profile.profilePicture?.url ?? kDefaultAvatar,
                    builder: (context, imageProvider) => Center(
                      child: Badge(
                        backgroundColor: Colors.transparent,
                        alignment: Alignment(0.5, 0.7),
                        label: CircleAvatar(
                          radius: 18,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                        child: Container(
                          width: kImageSize,
                          height: kImageSize,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: state is ProfileUpdateLoading
                                ? null
                                : DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                          child: state is ProfileUpdateLoading
                              ? StyledLoadingIndicator()
                              : null,
                        ),
                      ),
                    ),
                    imageSize: kImageSize,
                  ),
                ),
                Gap(27),
                InformationContainer(
                  title: "Details",
                  children: widgetInserter(
                    children: [
                      DetailsInfoItem(
                        title: "First name",
                        data: profile.firstName,
                      ),
                      DetailsInfoItem(
                        title: "Last name",
                        data: profile.lastName,
                      ),
                      DetailsInfoItem(
                        title: "Birthdate",
                        data: profile.birthdate != null
                            ? profile.birthdate!.appFormat
                            : profile.birthdate,
                      ),
                      DetailsInfoItem(
                        title: "Gender",
                        data: profile.sex.getDescription(context),
                      ),
                      DetailsInfoItem(
                        title: "Father's first name",
                        data: profile.fatherName,
                      ),
                      DetailsInfoItem(
                        title: "Mother's last name",
                        data: profile.motherName,
                      ),
                    ],
                    separator: Divider(
                      height: 30,
                      thickness: 1,
                    ),
                  ).toList(),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () => _onEditProfilePress(context, profile),
                  child: Text(
                    "Edit",
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
