// ignore_for_file: prefer_const_constructors, avoid_print, prefer_is_empty

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_api_test/modules/business.dart';
import 'package:flutter_application_api_test/modules/news_states.dart';
import 'package:flutter_application_api_test/modules/science.dart';
import 'package:flutter_application_api_test/modules/settings.dart';
import 'package:flutter_application_api_test/modules/technology.dart';
import 'package:flutter_application_api_test/shared/network/local/cach_helper.dart';
import 'package:flutter_application_api_test/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomsItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: "Business"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
    BottomNavigationBarItem(icon: Icon(Icons.laptop), label: "Technology"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
  ];
  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    TechnologyScreen(),
    SettingsScreen(),
  ];
  List<dynamic> business = [];
  List<dynamic> science = [];
  List<dynamic> technology = [];
  //////////////////////////////////////
  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) {
      getScience();
    }
    if (index == 2) {
      getTechnology();
    }
    emit(NewsBottomNavStates());
  }

  ///////////////////////////////////////////
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'business',
      'apiKey': 'd7d4593aa2924d448301cdce6b97c579'
    }).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
      print(business[0]['title']);
    }).catchError((onError) {
      print(onError.toString());
      emit(NewsGetBusinessErrorState(onError.toString()));
    });
  }

  /////////////////////////////////////////////////////////////////////////
  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'science',
        'apiKey': 'd7d4593aa2924d448301cdce6b97c579'
      }).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
        print(science[0]['title']);
      }).catchError((onError) {
        print(onError.toString());
        emit(NewsGetScienceErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  //////////////////////////////////////////////////////////////////////////
  void getTechnology() {
    emit(NewsGetTechnologyLoadingState());
    if (technology.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'technology',
        'apiKey': 'd7d4593aa2924d448301cdce6b97c579'
      }).then((value) {
        technology = value.data['articles'];
        emit(NewsGetTechnologySuccessState());
        print(technology[0]['title']);
      }).catchError((onError) {
        print(onError.toString());
        emit(NewsGetTechnologyErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetTechnologySuccessState());
    }
  }

  ///////////////////////////////////////////////////////////////////////
  bool isDark = false;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  //////////////////////////////////////////////////////////////////////
  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    search = [];
    if (search.length == 0) {
      DioHelper.getData(
              url: 'v2/everything',
              query: {'q': value, 'apiKey': 'd7d4593aa2924d448301cdce6b97c579'})
          .then((value) {
        search = value.data['articles'];
        emit(NewsGetSearchSuccessState());
        print(search[0]['title']);
      }).catchError((onError) {
        print(onError.toString());
        emit(NewsGetSearchErrorState(onError.toString()));
      });
    }
  }
}
