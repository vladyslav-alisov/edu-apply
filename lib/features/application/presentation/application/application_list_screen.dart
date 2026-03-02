import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_apply/core/common/widgets/styled_container.dart';
import 'package:edu_apply/core/common/widgets/styled_loading_indicator.dart';
import 'package:edu_apply/core/common/widgets/styled_no_data_widget.dart';
import 'package:edu_apply/core/router/app_routes.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/features/application/domain/entities/application.dart';
import 'package:edu_apply/features/application/presentation/application/application_bloc/application_bloc.dart';
import 'package:edu_apply/features/navigation_screen/presentation/navigation_cubit/navigation_cubit.dart';

class ApplicationListScreen extends StatefulWidget {
  const ApplicationListScreen({super.key});

  @override
  State<ApplicationListScreen> createState() => _ApplicationListScreenState();
}

class _ApplicationListScreenState extends State<ApplicationListScreen>
    with AutomaticKeepAliveClientMixin<ApplicationListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ApplicationBloc>().add(ApplicationFetch());
  }

  void _onApplicationPress(Application application) {
    context.go(
      AppRoutes.applicationDetails.path,
      extra: application,
    );
  }

  Future<void> _onRefresh() async {
    ApplicationBloc bloc = context.read<ApplicationBloc>();
    Future nextState = bloc.stream.first;
    bloc.add(ApplicationFetch());

    await nextState;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ApplicationBloc, ApplicationState>(
      listener: (context, state) {
        if (state is ApplicationFailure) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is ApplicationLoading) {
          return Center(
            child: StyledLoadingIndicator(),
          );
        }
        List<Application> applications = state.applicationList;

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: applications.isEmpty
              ? StyledScrollableNoDataWidget(
                  content: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Find Your Perfect Program',
                          style: Theme.of(context).textTheme.displayLarge,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Explore a world of academic possibilities. Whether you’re looking to study at home or abroad, we have thousands of university programs to help you find the right fit.',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 32),
                        Text(
                          'Get Started',
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Not sure where to begin? Search by program, degree type, or even your preferred location. We’ll help you discover the best options tailored to your career goals and academic interests.',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () => context
                              .read<NavigationCubit>()
                              .navigate(NavigationScreenRoute.programs),
                          child: Text(
                            'Start Your Search Now',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.separated(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  itemBuilder: (context, index) {
                    Application application = state.applicationList[index];
                    return GestureDetector(
                      onTap: () => _onApplicationPress(application),
                      child: StyledContainer(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    application.universityName ?? "--",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Gap(4),
                                  Text(
                                    application.universityProgramName ?? "",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  Gap(4),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: application.status.bgColor,
                                    ),
                                    child: Text(
                                      application.status.getTitle(context),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            color: application.status.textColor,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.keyboard_arrow_right_outlined),
                              onPressed: () => _onApplicationPress(application),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Gap(8),
                  itemCount: state.applicationList.length,
                ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
