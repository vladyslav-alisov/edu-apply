import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:edu_apply/core/common/widgets/icon_container.dart';
import 'package:edu_apply/core/common/widgets/items_found_text.dart';
import 'package:edu_apply/core/common/widgets/styled_loading_indicator.dart';
import 'package:edu_apply/core/router/app_routes.dart';
import 'package:edu_apply/core/utils/show_snack_bar.dart';
import 'package:edu_apply/features/program/domain/entities/program.dart';
import 'package:edu_apply/features/program/presentation/program_bloc/program_bloc.dart';
import 'package:edu_apply/features/program/presentation/screens/filter/filter_bottom_sheet.dart';
import 'package:edu_apply/features/program/presentation/widgets/program_list_inner_card.dart';
import 'package:edu_apply/features/program/presentation/widgets/search_text_field.dart';

const String kThrottleKey = "fetch-more";

class ProgramsSearchScreen extends StatefulWidget {
  const ProgramsSearchScreen({super.key});

  @override
  State<ProgramsSearchScreen> createState() => _ProgramsSearchScreenState();
}

class _ProgramsSearchScreenState extends State<ProgramsSearchScreen>
    with AutomaticKeepAliveClientMixin<ProgramsSearchScreen> {
  late final ScrollController _scrollController;
  late final TextEditingController _searchController;
  late FilterCriteriaState _filterCriteriaState;

  int get _timeToScroll =>
      context.read<ProgramBloc>().state.programList.length * 5;

  bool _isButtonVisible = false;

  @override
  void initState() {
    super.initState();
    _filterCriteriaState = FilterCriteriaState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _searchController = TextEditingController();
    context.read<ProgramBloc>().add(ProgramSearchPrograms());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onEditingComplete() {
    ProgramState state = context.read<ProgramBloc>().state;
    if (state.status == ProgramStateStatus.fetchLoading ||
        state.status == ProgramStateStatus.fetchMoreLoading) {
      return;
    }
    context.read<ProgramBloc>().add(ProgramSearchPrograms(
          name: _searchController.text,
          campusType: _filterCriteriaState.campusTypeFilter,
          countryCode: _filterCriteriaState.countryFilter,
          degreeType: _filterCriteriaState.degreeTypeFilter,
          durationInMonths: _filterCriteriaState.durationFilter,
          language: _filterCriteriaState.languageListFilter,
          maxFee: _filterCriteriaState.maxFeeFilter,
          minFee: _filterCriteriaState.minFeeFilter,
          modeOfStudy: _filterCriteriaState.modeOfStudyFilter,
          sortType: _filterCriteriaState.programTypeSort,
          university: _filterCriteriaState.universitiesFilter,
          universityType: _filterCriteriaState.universityTypeFilter,
        ));
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _onClosePress() {
    context.read<ProgramBloc>().add(ProgramSearchPrograms(
          campusType: _filterCriteriaState.campusTypeFilter,
          countryCode: _filterCriteriaState.countryFilter,
          degreeType: _filterCriteriaState.degreeTypeFilter,
          durationInMonths: _filterCriteriaState.durationFilter,
          language: _filterCriteriaState.languageListFilter,
          maxFee: _filterCriteriaState.maxFeeFilter,
          minFee: _filterCriteriaState.minFeeFilter,
          modeOfStudy: _filterCriteriaState.modeOfStudyFilter,
          sortType: _filterCriteriaState.programTypeSort,
          university: _filterCriteriaState.universitiesFilter,
          universityType: _filterCriteriaState.universityTypeFilter,
        ));
  }

  void _onScroll() {
    if (_scrollController.offset > 1000 && !_isButtonVisible) {
      setState(() => _isButtonVisible = true);
    }
    if (_scrollController.offset <= 1000 && _isButtonVisible) {
      setState(() => _isButtonVisible = false);
    }
  }

  void _onCardTap(Program program) {
    context.go(AppRoutes.programDetails.path, extra: program);
  }

  void _onApplyTap(Program program) {
    context.go(AppRoutes.programApplicationOverview.path, extra: program);
  }

  void _onFloatingActionButtonPress() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: _timeToScroll), curve: Curves.ease);
  }

  Future<void> _onRefresh() async {
    ProgramBloc bloc = context.read<ProgramBloc>();
    Future nextState = bloc.stream.first;
    bloc.add(
      ProgramSearchPrograms(
        name: _searchController.text,
        campusType: _filterCriteriaState.campusTypeFilter,
        countryCode: _filterCriteriaState.countryFilter,
        degreeType: _filterCriteriaState.degreeTypeFilter,
        durationInMonths: _filterCriteriaState.durationFilter,
        language: _filterCriteriaState.languageListFilter,
        maxFee: _filterCriteriaState.maxFeeFilter,
        minFee: _filterCriteriaState.minFeeFilter,
        modeOfStudy: _filterCriteriaState.modeOfStudyFilter,
        sortType: _filterCriteriaState.programTypeSort,
        university: _filterCriteriaState.universitiesFilter,
        universityType: _filterCriteriaState.universityTypeFilter,
      ),
    );

    await nextState;
  }

  bool _onScrollNotification(
      ScrollNotification scrollInfo, ProgramState state) {
    if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent &&
        state.status != ProgramStateStatus.fetchLoading &&
        state.status != ProgramStateStatus.fetchMoreLoading &&
        !state.isLastPage) {
      EasyThrottle.throttle(
        kThrottleKey,
        Duration(seconds: 1),
        () {
          context.read<ProgramBloc>().add(
                ProgramSearchProgramsMore(
                  name: _searchController.text,
                  page: state.currentPage + 1,
                  campusType: _filterCriteriaState.campusTypeFilter,
                  countryCode: _filterCriteriaState.countryFilter,
                  degreeType: _filterCriteriaState.degreeTypeFilter,
                  durationInMonths: _filterCriteriaState.durationFilter,
                  language: _filterCriteriaState.languageListFilter,
                  maxFee: _filterCriteriaState.maxFeeFilter,
                  minFee: _filterCriteriaState.minFeeFilter,
                  modeOfStudy: _filterCriteriaState.modeOfStudyFilter,
                  sortType: _filterCriteriaState.programTypeSort,
                  university: _filterCriteriaState.universitiesFilter,
                  universityType: _filterCriteriaState.universityTypeFilter,
                ),
              );
        },
      );
      return true;
    }
    return false;
  }

  void _onFilterPress() async {
    FilterCriteriaState? updatedFilter = await showBarModalBottomSheet(
      context: context,
      builder: (context) {
        return FilterBottomSheet(
          filterCurrentState: _filterCriteriaState,
        );
      },
    );

    if (updatedFilter != null && mounted) {
      _filterCriteriaState = updatedFilter;
      context.read<ProgramBloc>().add(
            ProgramSearchPrograms(
              name: _searchController.text,
              campusType: updatedFilter.campusTypeFilter,
              countryCode: updatedFilter.countryFilter,
              degreeType: updatedFilter.degreeTypeFilter,
              durationInMonths: updatedFilter.durationFilter,
              language: updatedFilter.languageListFilter,
              maxFee: updatedFilter.maxFeeFilter,
              minFee: updatedFilter.minFeeFilter,
              modeOfStudy: updatedFilter.modeOfStudyFilter,
              sortType: updatedFilter.programTypeSort,
              university: updatedFilter.universitiesFilter,
              universityType: updatedFilter.universityTypeFilter,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ProgramBloc, ProgramState>(
      listener: (context, state) {
        if (state.status == ProgramStateStatus.failure) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state.status == ProgramStateStatus.initLoading) {
          return Scaffold(body: Center(child: StyledLoadingIndicator()));
        }

        return Scaffold(
          floatingActionButton: _isButtonVisible
              ? FloatingActionButton(
                  onPressed: _onFloatingActionButtonPress,
                  child: const Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  ),
                )
              : null,
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) =>
                _onScrollNotification(notification, state),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: RefreshIndicator(
                onRefresh: () => _onRefresh(),
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 110,
                      floating: true,
                      pinned: false,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: SearchTextField(
                                      searchController: _searchController,
                                      onEditingComplete: _onEditingComplete,
                                      onClosePress: _onClosePress,
                                    ),
                                  ),
                                  Gap(8),
                                  GestureDetector(
                                    onTap: _onFilterPress,
                                    child: Badge(
                                      isLabelVisible:
                                          _filterCriteriaState.nFiltersOn != 0,
                                      alignment: Alignment(-1.7, -1.3),
                                      label: Text(_filterCriteriaState
                                          .nFiltersOn
                                          .toString()),
                                      child: IconContainer(
                                        child: SizedBox(
                                          height: 28,
                                          width: 28,
                                          child: Icon(
                                            Icons.filter_alt_outlined,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Gap(8),
                              ItemsFoundText(
                                title: "Programs found: ",
                                totalElements: state.totalElements,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    state.status == ProgramStateStatus.fetchLoading
                        ? SliverFillRemaining(
                            child: Center(child: StyledLoadingIndicator()),
                          )
                        : state.programList.isEmpty
                            ? SliverFillRemaining(
                                child:
                                    Center(child: Text("No programs found :(")),
                              )
                            : SliverList.separated(
                                itemCount: state.programList.length +
                                    (state.status ==
                                            ProgramStateStatus.fetchMoreLoading
                                        ? 1
                                        : 0),
                                separatorBuilder: (context, index) => Gap(12),
                                itemBuilder: (context, index) {
                                  if (state.programList.length == index) {
                                    return Column(
                                      children: [
                                        Gap(12),
                                        Center(child: StyledLoadingIndicator()),
                                      ],
                                    );
                                  }
                                  Program program = state.programList[index];
                                  return ProgramSummaryCard(
                                    program: program,
                                    onCardTap: _onCardTap,
                                    onApplyTap: _onApplyTap,
                                  );
                                },
                              ),
                    SliverToBoxAdapter(
                      child: Gap(24),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
