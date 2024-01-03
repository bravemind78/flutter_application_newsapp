abstract class NewsStates {}

class NewsInitialStates extends NewsStates {}

class NewsBottomNavStates extends NewsStates {}

class NewsGetBusinessLoadingState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  final String error;
  NewsGetBusinessErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsStates {}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {
  final String error;
  NewsGetScienceErrorState(this.error);
}

class NewsGetTechnologyLoadingState extends NewsStates {}

class NewsGetTechnologySuccessState extends NewsStates {}

class NewsGetTechnologyErrorState extends NewsStates {
  final String error;
  NewsGetTechnologyErrorState(this.error);
}

class AppChangeModeState extends NewsStates {}

class NewsGetSearchLoadingState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  final String error;
  NewsGetSearchErrorState(this.error);
}
