import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/layout/news_app/cubit/cubit.dart';
import 'package:untitled4/layout/news_app/cubit/states.dart';

import '../../../shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(

      listener:(context,state){} ,
      builder: (context,state)
      {
         var list  =NewsCubit.get(context).business;
         return articleBuilder(list,context);
      }

    );
  }
}
