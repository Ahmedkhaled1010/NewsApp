import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled4/firebase_options.dart';
import 'package:untitled4/layout/news_app/cubit/cubit.dart';
import 'package:untitled4/layout/shop_app/cupit/cupit.dart';
import 'package:untitled4/layout/shop_app/shop_layout.dart';
import 'package:untitled4/layout/social_app/cupit/cubit.dart';
import 'package:untitled4/layout/social_app/social_screen.dart';
import 'package:untitled4/modules/social_app/social_login/social_login_screen.dart';

import 'package:untitled4/shared/bloc_observer.dart';
import 'package:untitled4/shared/components/constants.dart';
import 'package:untitled4/shared/cubit/cubit.dart';
import 'package:untitled4/shared/cubit/states.dart';
import 'package:untitled4/shared/network/local/cache_helper.dart';
//import 'package:untitled4/shared/cubit/cubit.dart';
//import 'package:untitled4/shared/cubit/states.dart';
import 'package:untitled4/shared/network/remote/dio_helper.dart';
import 'package:untitled4/shared/styles/Theme.dart';


import 'layout/news_app/cubit/states.dart';
import 'layout/news_app/news_layout.dart';
import 'layout/to_do_layout/home_layout.dart';
import 'modules/bmi_app/bmi/Bmi_screen.dart';
import 'modules/basics_app/counter/CounterScreen.dart';
import 'modules/basics_app/userScreen/User_screen.dart';
import 'modules/shop_app/login/shop_login_screen.dart';
import 'modules/shop_app/on_boarding/on_boarding.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: "isDark");
  Widget widget;
  // bool? onBoarding = CacheHelper.getData(key: "onBoarding");
  //  token = CacheHelper.getData(key: "token");
  //  print(token);
   uid = CacheHelper.getData(key: "uid");

  //
  // if(onBoarding != null)
  //   {
  //     if(token!= null) widget =ShopLayout();
  //     else widget = ShopLoginScreen();
  //   }else widget = OnBoardingScreen();
  if(uid != null)
    {
      widget =SocialLayout();
    }
  else
    {
      widget =SocialLoginScreen();
    }

  runApp( MyApp(
    isDark :isDark??false,
    widget:widget,
  ));
}

class MyApp extends StatelessWidget {

  final bool isDark;
  final Widget widget;

  MyApp({required this.isDark,required this.widget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return
      MultiBlocProvider(
      providers: [
        BlocProvider( create: (context)=>NewsCubit()..getBusiness()..getSports()..getScience(),),
        BlocProvider(create: (context)=>AppCubit()..changeAppMode(isDark),),
      BlocProvider(create: (context)=> ShopCupit()..getHomeData()..getCategory()..getFavorite()..getUserData()),
BlocProvider(create: (context)=>SocialCupit()..getUser()),
      ],


        child: BlocConsumer<AppCubit,AppStates>(
          listener: (context,states){},
          builder: (context,states)
          {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              themeMode: AppCubit.get(context).isDark ==false  ? ThemeMode.light:ThemeMode.dark,
              darkTheme: darkTheme,
              home: widget,
            );
          },

        ),

    );
  }
}

