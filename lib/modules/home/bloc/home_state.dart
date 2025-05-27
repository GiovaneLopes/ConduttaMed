part of './home_cubit.dart';

class HomeState extends Equatable {
  final int currentTab;
  const HomeState({
    this.currentTab = 0,
  });

  HomeState copyWith({
    int? currentTab,
  }) {
    return HomeState(
      currentTab: currentTab ?? this.currentTab,
    );
  }

  @override
  List<Object> get props => [currentTab];
}
