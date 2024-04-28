import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/layout/news_app/cubit/cubit.dart';
import 'package:untitled4/layout/news_app/cubit/states.dart';
import 'package:untitled4/modules/news_app/search/search_screen.dart';
import 'package:untitled4/shared/components/components.dart';
import 'package:untitled4/shared/network/remote/dio_helper.dart';

import '../../shared/cubit/cubit.dart';
class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
       BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          var cubit =NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "News App ",

              ),
              actions: [
               IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen(),);
                  },
                  icon: Icon(Icons.search),),
                IconButton(
                  onPressed: ()
                  {
                    AppCubit.get(context).changeAppMode();
                  },
                  icon: Icon(Icons.brightness_4_outlined),)
              ]
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomItem,
              currentIndex: cubit.currentIndex ,
              onTap: (index){
                cubit.changeBottomNavBar(index);
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: ()
              {

              },
              child: Icon(
                Icons.add,
              ),
            ),
            body: cubit.screens[cubit.currentIndex],

          );
        },


    );
  }
}
