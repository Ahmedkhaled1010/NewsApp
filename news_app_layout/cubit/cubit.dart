import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/layout/news_app/cubit/states.dart';
import 'package:untitled4/modules/news_app/business/business_screen.dart';
import 'package:untitled4/modules/news_app/science/science_screen.dart';
import 'package:untitled4/modules/settings/settings_screen.dart';
import 'package:untitled4/modules/news_app/sports/sports_screen.dart';

import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit( ): super(NewsInitialState());
  static NewsCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<Widget> screens =
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  //  SettingsScreen(),

  ];
  List<dynamic> business =[];
  List<dynamic> sports =[];
  List<dynamic> science =[];
  List<dynamic> search =[];

  List<BottomNavigationBarItem> bottomItem =[
    BottomNavigationBarItem(
        icon:
        Icon(Icons.business),
      label: "business",),
    BottomNavigationBarItem(
      icon:
      Icon(Icons.sports),
      label: "sports",),
    BottomNavigationBarItem(
      icon:
      Icon(Icons.science),
      label: "science",),
    // BottomNavigationBarItem(
    //   icon:
    //   Icon(Icons.settings),
    //   label: "settings",),
  ];
  void changeBottomNavBar(int index)
  {
    currentIndex=index;
    // if(index==1)
    //   getSports();
    // else if(index==2)
    //   getScience();
    emit(NewsBottomState());
  }
  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: "v2/top-headlines",
      query:{ "country":"eg",
        "category":"business",

        "apiKey":"8b48ed4f728d40d58771ccc922e5fd14",
      },
    ).then((value) {
      // print(value!.data['articles'][0]['title'].toString());
      business= value!.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(NewsGetBusinessErrorState(onError.toString()));
    });
  }
  void getSports()
  {
    emit(NewsGetSportsLoadingState());
    if(sports.length==0)
      {
        DioHelper.getData(
          url: "v2/top-headlines",
          query:{ "country":"eg",
            "category":"sports",

            "apiKey":"8b48ed4f728d40d58771ccc922e5fd14",
          },
        ).then((value) {
          // print(value!.data['articles'][0]['title'].toString());
          sports= value!.data['articles'];
          print(sports[0]['title']);
          emit(NewsGetSportsSuccessState());
        }).catchError((onError){
          print(onError.toString());
          emit(NewsGetSportsErrorState(onError.toString()));
        });
      }else{ emit(NewsGetSportsSuccessState());}

  }
  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    if(science.length==0)
      {
        DioHelper.getData(
          url: "v2/top-headlines",
          query:{ "country":"eg",
            "category":"science",

            "apiKey":"8b48ed4f728d40d58771ccc922e5fd14",
          },
        ).then((value) {
          // print(value!.data['articles'][0]['title'].toString());
          science= value!.data['articles'];
          print(science[0]['title']);
          emit(NewsGetScienceSuccessState());
        }).catchError((onError){
          print(onError.toString());
          emit(NewsGetScienceErrorState(onError.toString()));
        });
      }else{ emit(NewsGetScienceSuccessState());}

  }
  void getSearch(String value)
  {

    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: "v2/everything",
      query:{
        "q":"$value",


        "apiKey":"8b48ed4f728d40d58771ccc922e5fd14",
      },
    ).then((value) {
      // print(value!.data['articles'][0]['title'].toString());
      search= value!.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(NewsGetSearchErrorState(onError.toString()));
    });
  }
  // bool isDark =false;
  // void changeAppMode()
  // {
  //   isDark = !isDark;
  //   print("change");
  //   emit(NewsAppChangeModeState());
  }
