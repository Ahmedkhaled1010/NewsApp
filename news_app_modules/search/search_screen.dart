import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/layout/news_app/cubit/cubit.dart';
import 'package:untitled4/layout/news_app/cubit/states.dart';

import '../../../shared/components/components.dart';
class SearchScreen extends StatelessWidget {



  var searchController =TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var list =NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body:Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                    controller: searchController,
                    label: "search",
                    keyType:TextInputType.text ,
                    onSubmitted: (){} ,
                    validate: (value)
                    {
                      if(value!.isEmpty){
                        return "The search must not be empty";
                      }
                      return null;
                    },
                    prefix: Icons.search ,
                    // onChange: (value)
                    // {
                    //   NewsCubit.get(context).getSearch(value);
                    //
                    // }

                ),
              ),
                Expanded(child: articleBuilder(list, context))
            ],
          ),

        );
      },

    );
  }
}
