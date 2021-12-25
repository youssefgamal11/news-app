abstract class NewsStates {}

class NewsInitalState extends NewsStates {}

class ChangeNavigationBar extends NewsStates {}

class GetBusinessIsLoadingState extends NewsStates {}

class GetBusinessIsSucessState extends NewsStates {}

class GetBusinessErrorState extends NewsStates {
  final String error;

  GetBusinessErrorState(this.error);
}

class GetSportsIsLoadingState extends NewsStates {}

class GetSportsIsSucessState extends NewsStates {}

class GetSportsErrorState extends NewsStates {
  final String error;

  GetSportsErrorState(this.error);
}

class GetScienceIsLoadingState extends NewsStates {}

class GetScienceIsSucessState extends NewsStates {}

class GetScienceErrorState extends NewsStates {
  final String error;

  GetScienceErrorState(this.error);
}


class GetSearchIsLoadingState extends NewsStates {}

class GetSearchIsSucessState extends NewsStates {}

class GetSearchErrorState extends NewsStates {
  final String error;

  GetSearchErrorState(this.error);
}
class ChangeModeState extends NewsStates{}