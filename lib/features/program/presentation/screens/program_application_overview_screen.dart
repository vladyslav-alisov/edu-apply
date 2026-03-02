import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_apply/core/common/widgets/details_info_item.dart';
import 'package:edu_apply/core/common/widgets/styled_cached_network_image.dart';
import 'package:edu_apply/core/common/widgets/styled_close_icon_button.dart';
import 'package:edu_apply/core/common/widgets/styled_container.dart';
import 'package:edu_apply/core/common/widgets/styled_full_screen_loading_widget.dart';
import 'package:edu_apply/core/router/app_routes.dart';
import 'package:edu_apply/core/theme/color_scheme.dart';
import 'package:edu_apply/core/utils/date_time_extensions.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/core/utils/string_extensions.dart';
import 'package:edu_apply/core/utils/widget_inserter.dart';
import 'package:edu_apply/features/application/presentation/application/application_bloc/application_bloc.dart';
import 'package:edu_apply/features/profile/domain/entities/profile.dart';
import 'package:edu_apply/features/profile/presentation/profile_bloc/profile_bloc.dart';
import 'package:edu_apply/features/program/domain/entities/program.dart';
import 'package:edu_apply/features/program/presentation/widgets/information_container.dart';
import 'package:edu_apply/features/program/presentation/widgets/university_list_tile.dart';

class ProgramApplicationOverviewScreen extends StatelessWidget {
  const ProgramApplicationOverviewScreen({
    super.key,
    required Program program,
  }) : _program = program;

  final Program _program;

  void _onTap(BuildContext context) {
    context.pop();
  }

  void _onSubmitPress(BuildContext context) {
    context.read<ApplicationBloc>().add(
          ApplicationCreate(
            universityId: _program.universityId,
            universityProgramId: _program.id,
            tuitionFee: _program.tuitionFee,
            periodId: _program.dates.firstOrNull?.id ?? "",
          ),
        );
  }

  int _calculateDiscount(double totalPrice, int? discount) {
    if (discount == null) return 0;

    return (totalPrice * (discount / 100)).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApplicationBloc, ApplicationState>(
      listener: (context, state) {
        if (state is ApplicationFailure) {
          showSnackBar(context, state.message);
        }
        if (state is ApplicationSuccess) {
          context.go(
            AppRoutes.applicationDetails.path,
            extra: state.applicationList.last,
          );
        }
      },
      builder: (context, state) {
        int discount = _calculateDiscount(
            _program.tuitionFee, _program.discountPercentage);
        return StyledFullScreenLoadingWidget(
          isLoading: state is ApplicationLoading,
          child: Scaffold(
            persistentFooterButtons: [
              Padding(
                padding:
                    const EdgeInsets.only(right: 16.0, left: 16, bottom: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (discount != 0) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tuition fee",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            _program.currency
                                .showWithNumber(_program.tuitionFee),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Discount",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            "-${_program.currency.showWithNumber(_calculateDiscount(_program.tuitionFee, _program.discountPercentage!))}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: kMoneyIconColor),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total price",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Text(
                          _program.currency.showWithNumber(
                              _program.tuitionFee.toInt() - discount),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                    Gap(8),
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () => _onSubmitPress(context),
                        child: Text("Submit"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            body: Container(
              color: Colors.white,
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 24, right: 24, top: 39, bottom: 29),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Add new application",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              Gap(4),
                              Text(
                                "Complete the application quickly by choosing the program and season 🎉",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Gap(20),
                        StyledCloseIconButton(
                          onTap: () => _onTap(context),
                        ),
                      ],
                    ),
                  ),
                  Gap(16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        UniversityListTile(
                          universityName: _program.universityName,
                          universityLogoUrl: _program.universityLogo.url,
                          degreeType: _program.degreeType,
                          programName: _program.name,
                        ),
                        Gap(16),
                        InformationContainer(
                          title: "Details",
                          children: widgetInserter(
                            children: [
                              DetailsInfoItem(
                                title: "Education language",
                                data: _program.language.capitalize,
                                iconData: Icons.language_outlined,
                              ),
                              DetailsInfoItem(
                                title: "Duration",
                                data: "${_program.duration ~/ 12} years",
                                iconData: Icons.view_timeline_outlined,
                              ),
                              DetailsInfoItem(
                                title: "Mode of study",
                                data: _program.modeOfStudy.getTitle(context),
                                iconData: Icons.watch_later_outlined,
                              ),
                              DetailsInfoItem(
                                title: "Location",
                                data: _program.universityCountry?.countryName,
                                iconData: Icons.timer_outlined,
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
                          title: "Intake",
                          children: [
                            DetailsInfoItem(
                              title: "Season",
                              data: _program.programStartMonth.appSeasonFormat,
                            ),
                          ],
                        ),
                        Gap(16),
                        BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            Profile profile = state.profile;
                            const double kImageSize = 48;
                            return StyledContainer(
                              padding: EdgeInsets.zero,
                              child: ListTile(
                                leading: StyledCachedNetworkImage(
                                  imageUrl: profile.profilePicture?.url ?? "",
                                  builder: (context, imageProvider) =>
                                      Container(
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
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  imageSize: kImageSize,
                                ),
                                title: Text(
                                  profile.fullName,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                subtitle: Text(
                                  profile.email,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Gap(16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
