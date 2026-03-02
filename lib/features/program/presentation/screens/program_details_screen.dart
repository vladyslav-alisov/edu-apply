import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_apply/core/common/widgets/details_info_item.dart';
import 'package:edu_apply/core/router/app_routes.dart';
import 'package:edu_apply/core/theme/color_scheme.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/core/utils/string_extensions.dart';
import 'package:edu_apply/core/utils/widget_inserter.dart';
import 'package:edu_apply/features/application/presentation/application/application_details_screen.dart';
import 'package:edu_apply/features/program/domain/entities/program.dart';
import 'package:edu_apply/features/program/presentation/widgets/information_container.dart';
import 'package:edu_apply/features/program/presentation/widgets/university_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _whatsUpUrl = Uri.parse('https://wa.me/+999123456789');

class ProgramDetailsScreen extends StatelessWidget {
  const ProgramDetailsScreen({
    super.key,
    required Program program,
  }) : _program = program;

  final Program _program;

  void _onApplyPress(BuildContext context) {
    context.push(
      AppRoutes.programApplicationOverview.path,
      extra: _program,
    );
  }

  void _onTalkToSpecialistPress(BuildContext context) async {
    bool response = await launchUrl(_whatsUpUrl);

    if (!response && context.mounted) {
      showSnackBar(
          context, "Something went wrong. Please, contact administrator");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ElevatedButton(
              onPressed: () => _onApplyPress(context),
              child: Text("Apply"),
            ),
          ),
        ),
      ],
      appBar: AppBar(
        title: Text("Program"),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 12),
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Gap(12),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 10),
                  child: UniversityListTile(
                    universityName: _program.universityName,
                    universityLogoUrl: _program.universityLogo.url,
                    degreeType: _program.degreeType,
                    programName: _program.name,
                  ),
                ),
              ],
            ),
          ),
          Gap(12),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: Column(
              children: [
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
                Gap(12),
                InformationContainer(
                  title: 'Price',
                  children: widgetInserter(
                    children: [
                      DetailsInfoItem(
                        title: "Tuition fee",
                        data: _program.currency
                            .showWithNumber(_program.tuitionFee),
                        iconData: Icons.attach_money,
                        iconColor: kMoneyIconColor,
                      ),
                      DetailsInfoItem(
                        title: "Discount percentage",
                        data: _program.discountPercentage != null
                            ? "${_program.discountPercentage} %"
                            : _program.discountPercentage,
                        iconData: Icons.percent,
                        iconColor: kMoneyIconColor,
                      ),
                      DetailsInfoItem(
                        title: "Deposit",
                        data:
                            _program.currency.showWithNumber(_program.deposit),
                        iconData: Icons.account_balance_wallet_outlined,
                        iconColor: kMoneyIconColor,
                      ),
                      DetailsInfoItem(
                        title: "Sibling discount",
                        data: _program.siblingDiscountPercentage != null
                            ? "${_program.siblingDiscountPercentage!.toInt()} %"
                            : _program.siblingDiscountPercentage,
                        iconData: Icons.local_offer_outlined,
                        iconColor: kMoneyIconColor,
                      ),
                      DetailsInfoItem(
                        title: "Number of installations",
                        data: _program.numberOfInstallations != null
                            ? "${_program.numberOfInstallations!.toInt()}"
                            : _program.numberOfInstallations,
                        iconData: Icons.download,
                        iconColor: kMoneyIconColor,
                      ),
                      DetailsInfoItem(
                        title: "Cash discount",
                        data: _program.cashPaymentDiscountPercentage != null
                            ? "${_program.cashPaymentDiscountPercentage!.toInt()} %"
                            : _program.cashPaymentDiscountPercentage,
                        iconData: Icons.percent,
                        iconColor: kMoneyIconColor,
                      ),
                    ],
                    separator: Divider(
                      height: 30,
                      thickness: 1,
                    ),
                  ).toList(),
                ),
                Gap(12),
                ButtonTextContainer(
                  title: "Talk with a specialist",
                  iconData: Icons.call,
                  buttonTitle: "Start WhatsApp Chat",
                  onPressed: () => _onTalkToSpecialistPress(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
