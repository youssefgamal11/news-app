import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitalState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> navigationItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports_baseball), label: 'sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'science'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings'),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  changeNavigationIndex(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    } else if (index == 2) {
      getScience();
    } else {}

    emit(ChangeNavigationBar());
  }

  List<dynamic> business = [];

  void getBusiness() {
    business = [];
    emit(GetBusinessIsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'b742fb11c6a040f4af7c143b0ac063e3'
      },
    ).then((value) {
      emit(GetBusinessIsSucessState());
      business = value.data['articles'];
    }).catchError((e) {
      emit(GetBusinessErrorState(e.toString()));
      print('this error has happned ${e.toString()}');
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    sports = [] ;
    emit(GetSportsIsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'b742fb11c6a040f4af7c143b0ac063e3'
      },
    ).then((value) {
      emit(GetSportsIsSucessState());
      sports = value.data['articles'];
    }).catchError((e) {
      emit(GetSportsErrorState(e.toString()));
      print('this error has happened ${e.toString()}');
    });
  }

  List<dynamic> science = [];

  void getScience() {
    science=[];
    emit(GetScienceIsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'b742fb11c6a040f4af7c143b0ac063e3'
      },
    ).then((value) {
      emit(GetScienceIsSucessState());
      science = value.data['articles'];
    }).catchError((e) {
      emit(GetScienceErrorState(e.toString()));
      print('this error has happened ${e.toString()}');
    });
  }



  List<dynamic> search = [];
  void getSearch(String value) {
    emit(GetSearchIsLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {'q': '$value', 'apiKey': 'b742fb11c6a040f4af7c143b0ac063e3'},
    ).then((value) {
      emit(GetSearchIsSucessState());
      science = value.data['articles'];
    }).catchError((e) {
      emit(GetSearchErrorState(e.toString()));
      print('this error has happened ${e.toString()}');
    });
  }


  bool isDark = false;

  void changeMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeModeState());
    } else {
      isDark = !isDark;

      CacheHelper.putBoolen(key: 'isDark', value: isDark).then((value) => {
        emit(ChangeModeState()),
      });
    }
  }
}
