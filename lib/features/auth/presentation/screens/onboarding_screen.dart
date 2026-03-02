import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_apply/core/const/assets.gen.dart';
import 'package:edu_apply/core/l10n/translate_extension.dart';
import 'package:edu_apply/core/router/app_routes.dart';

enum OnboardingSlide {
  section1(),
  section2(),
  section3(),
  section4();

  const OnboardingSlide();

  String getImagePath() {
    return switch (this) {
      OnboardingSlide.section1 => Assets.images.onboarding1.path,
      OnboardingSlide.section2 => Assets.images.onboarding2.path,
      OnboardingSlide.section3 => Assets.images.onboarding3.path,
      OnboardingSlide.section4 => Assets.images.onboarding4.path,
    };
  }

  String getTitle(BuildContext context) {
    return switch (this) {
      OnboardingSlide.section1 => context.l10n.welcome,
      OnboardingSlide.section2 => context.l10n.search,
      OnboardingSlide.section3 => context.l10n.apply,
      OnboardingSlide.section4 => context.l10n.travel,
    };
  }

  String getDescription(BuildContext context) {
    return switch (this) {
      OnboardingSlide.section1 => context.l10n.onboarding_1,
      OnboardingSlide.section2 => context.l10n.onboarding_2,
      OnboardingSlide.section3 => context.l10n.onboarding_3,
      OnboardingSlide.section4 => context.l10n.onboarding_4,
    };
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  late int _selectedPage;

  @override
  void initState() {
    super.initState();
    _selectedPage = 0;
    _pageController = PageController(initialPage: _selectedPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _selectedPage = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(
              flex: 1,
            ),
            Flexible(
              flex: 8,
              child: PageView(
                onPageChanged: _onPageChanged,
                children: List.generate(
                  OnboardingSlide.values.length,
                  (index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                            OnboardingSlide.values[index].getImagePath()),
                        const Gap(20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            children: [
                              Text(
                                OnboardingSlide.values[_selectedPage]
                                    .getTitle(context),
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const Gap(4),
                              Text(
                                OnboardingSlide.values[_selectedPage]
                                    .getDescription(context),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Gap(10),
            DotsIndicator(
              dotsCount: 4,
              position: _selectedPage.toDouble(),
              decorator: DotsDecorator(
                size: const Size.square(6),
                spacing: const EdgeInsets.all(4),
                activeSize: const Size(24.0, 6.0),
                color: Theme.of(context).colorScheme.secondary,
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.go(AppRoutes.login.path);
                          },
                          child: Text(context.l10n.login),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            context.go(AppRoutes.signUp.path);
                          },
                          child: Text(context.l10n.signUp),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
