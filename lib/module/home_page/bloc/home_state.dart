abstract class HomeState {}

class HomeInital extends HomeState {}

class HomeChangePage extends HomeState {
  int index;
  HomeChangePage({required this.index});
}
