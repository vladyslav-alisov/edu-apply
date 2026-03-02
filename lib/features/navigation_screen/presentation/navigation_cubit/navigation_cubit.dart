import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';

enum NavigationScreenRoute {
  programs(0),
  applications(1),
  profile(2);

  const NavigationScreenRoute(this.routeIndex);

  final int routeIndex;
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial(index: 0));

  void navigate(NavigationScreenRoute screen) {
    if (screen.routeIndex == state.index) return;
    emit(NavigationInitial(index: screen.routeIndex));
  }
}
