part of 'navigation_cubit.dart';

@immutable
sealed class NavigationState {
  final int index;

  const NavigationState({required this.index});
}

final class NavigationInitial extends NavigationState {
  const NavigationInitial({required super.index});
}
