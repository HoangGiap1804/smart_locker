abstract class HomeEvent{}

class ChangePage extends HomeEvent{
  int index;
  ChangePage({
    required this.index,
  });
}

