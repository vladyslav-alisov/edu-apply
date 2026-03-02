import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_apply/core/common/widgets/app_bar_image.dart';
import 'package:edu_apply/core/router/app_routes.dart';
import 'package:edu_apply/features/application/presentation/application/application_list_screen.dart';
import 'package:edu_apply/features/auth/data/data_sources/auth_persistent_data_source.dart';
import 'package:edu_apply/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:edu_apply/features/navigation_screen/presentation/navigation_cubit/navigation_cubit.dart';
import 'package:edu_apply/features/profile/presentation/screens/profile_screen.dart';
import 'package:edu_apply/features/program/presentation/screens/programs_search_screen.dart';
import 'package:edu_apply/init_dependencies.main.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  void initState() {
    super.initState();
    _navBarScreens = [
      ProgramsSearchScreen(),
      ApplicationListScreen(),
      ProfileScreen(),
    ];
  }

  late final List<Widget> _navBarScreens;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            serviceLocator<AuthPersistentDataSource>().deleteAccessToken();
            serviceLocator<AuthPersistentDataSource>().deleteRefreshToken();
            context.go(AppRoutes.onboarding.path);
          }
        },
        child: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: false,
                title: Text(
                  ["Programs", "My Applications", "Profile"][state.index],
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              body: IndexedStack(
                index: state.index,
                children: _navBarScreens,
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (value) => context.read<NavigationCubit>().navigate(
                      NavigationScreenRoute.values[value],
                    ),
                currentIndex: state.index,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Programs"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.school), label: "My Applications"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: "Profile"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
