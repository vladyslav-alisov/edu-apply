import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';
import 'package:edu_apply/core/common/widgets/styled_cached_network_image.dart';
import 'package:edu_apply/core/common/widgets/styled_container.dart';
import 'package:edu_apply/core/common/widgets/styled_loading_indicator.dart';
import 'package:edu_apply/core/common/widgets/styled_option_dialog.dart';
import 'package:edu_apply/core/const/assets.gen.dart';
import 'package:edu_apply/core/router/app_routes.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';
import 'package:edu_apply/features/profile/presentation/screens/family_information_edit_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

const double kImageSize = 48;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

const String kDefaultAvatar =
    "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541";

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isFeedbackLoading = false;
  bool _isShareLoading = false;

  void _onLogoutTap() async {
    bool response = await showDialog(
      context: context,
      builder: (context) => StyledOptionDialog(
        content: "Are you sure you want to log out?",
        confirmLabel: "Logout",
      ),
    );
    if (response && mounted) {
      context.read<AuthBloc>().add(AuthLogout());
    }
  }

  void _onShareAppPress() async {
    if (_isShareLoading) return;
    setState(() => _isShareLoading = true);
    try {
      String store =
          "App URL for ${Platform.isIOS ? 'AppStore' : 'PlayMarket'}";
      await SharePlus.instance.share(ShareParams(text: store));
    } catch (e) {
      if (!mounted) return;
      AlertDialog(
        title: Text("Error"),
        content: Text(e.toString()),
      );
    } finally {
      setState(() => _isShareLoading = false);
    }
  }

  void _onFeedbackPress() async {
    if (_isFeedbackLoading) return;
    setState(() => _isFeedbackLoading = true);
    try {
      String feedbackEmail = "vladyslav.alisov@gmail.com";
      String subject = "Feedback EduAdmire";
      Uri mailTo = Uri.parse("mailto:$feedbackEmail?subject=$subject");
      bool canLaunch = await canLaunchUrl(mailTo);
      if (canLaunch) {
        await launchUrl(mailTo);
      }
    } catch (e) {
      if (!mounted) return;
      AlertDialog(
        title: Text("Error"),
        content: Text(e.toString()),
      );
    } finally {
      setState(() => _isFeedbackLoading = false);
    }
  }

  void _onAboutPress(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: "EduApply",
      children: [
        Text(
            "EduApply was created to simplify one of the most stressful journeys in a student’s life: getting into university.\nWe believe talented students should not miss opportunities because of confusing application systems, deadlines, paperwork, or lack of guidance. Our platform is designed to support students from the very first search to the moment they are officially enrolled."),
      ],
      applicationIcon: Image.asset(
        Assets.images.logoAppbar.path,
        height: 55,
        width: 55,
      ),
    );
  }

  void _onFamilyInfoEditPress(Profile profile) {
    showBarModalBottomSheet(
      context: context,
      builder: (context) => FamilyInformationEditSheet(
        motherName: profile.motherName,
        fatherName: profile.fatherName,
      ),
    );
  }

  void _onProfileDetailsPress() async {
    context.push(AppRoutes.profileDetails.path);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (BuildContext context, ProfileState state) {
          if (state is ProfileUpdateFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state.isProfileInitialized) {
            Profile profile = state.profile;
            return ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              children: [
                StyledContainer(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    onTap: _onProfileDetailsPress,
                    leading: StyledCachedNetworkImage(
                      imageUrl: profile.profilePicture?.url ?? kDefaultAvatar,
                      builder: (context, imageProvider) => Container(
                        width: kImageSize,
                        height: kImageSize,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
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
                      imageSize: kImageSize,
                    ),
                    title: Text(
                      profile.fullName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      "Personal details",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 16,
                    ),
                  ),
                ),
                Gap(24),
                Text(
                  "Additional information",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Gap(12),
                StyledContainer(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person_outline),
                        title: Text("Contact"),
                        onTap: () =>
                            context.push(AppRoutes.profileContact.path),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 16,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.account_box_outlined),
                        title: Text("Passport"),
                        onTap: () =>
                            context.push(AppRoutes.profilePassport.path),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 16,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.school_outlined),
                        title: Text("Education"),
                        onTap: () =>
                            context.push(AppRoutes.profileEducation.path),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 16,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.g_translate_outlined),
                        title: Text("Language certificate"),
                        onTap: () => context
                            .push(AppRoutes.profileLanguageCertificate.path),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 16,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.folder_copy_outlined),
                        title: Text("Additional documents"),
                        onTap: () => context
                            .push(AppRoutes.profileAdditionalDocuments.path),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(24),
                Text(
                  "Settings",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Gap(12),
                StyledContainer(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.info_outline),
                        title: Text("About"),
                        onTap: () => _onAboutPress(context),
                      ),
                      ListTile(
                        leading: Icon(Icons.feedback_outlined),
                        title: Text("Feedback"),
                        onTap: _onFeedbackPress,
                        trailing: _isFeedbackLoading
                            ? const StyledLoadingIndicator()
                            : null,
                      ),
                      ListTile(
                        leading: Icon(Icons.share_outlined),
                        title: Text("Share"),
                        onTap: _onShareAppPress,
                        trailing: _isShareLoading
                            ? const StyledLoadingIndicator()
                            : null,
                      ),
                    ],
                  ),
                ),
                Gap(12),
                StyledContainer(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    onTap: _onLogoutTap,
                    leading: Icon(
                      Icons.logout_outlined,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    title: Text(
                      "Logout",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ),
                Gap(12),
                StyledContainer(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    onTap: () {
                      showSnackBar(context, "Not implemented yet");
                    },
                    leading: Icon(
                      Icons.logout_outlined,
                      color: Theme.of(context).colorScheme.onPrimaryFixed,
                    ),
                    title: Text(
                      "Delete account",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryFixed,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text("Profile is not available"),
            );
          }
        },
      ),
    );
  }
}
