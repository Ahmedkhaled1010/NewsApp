import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled4/modules/news_app/web_view/web_view_screen.dart';
import 'package:untitled4/shared/cubit/cubit.dart';

import '../../layout/shop_app/cupit/cupit.dart';
import '../styles/color.dart';

Widget defaultButton({
  required double width,
  required Color color,
  required Function function,
  required String name,
})=> Container(
  width: width,
  color: color,
  child: MaterialButton(onPressed: ()
  {
    function();
  },



    child: Text(
      name!.toUpperCase() ,
      style: TextStyle(
          color: Colors.white
      ),
    ),

  ),
);
Widget defaultTextButton({
  required String name,
  Function? pressed,

})=>   TextButton(
  onPressed:()
  {
    pressed!();
  },
   child: Text(
    "${name.toUpperCase()}",
),);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyType,
  required Function validate,
 required String label,
  required IconData prefix,
  IconData? suffix ,
  required Function onSubmitted,

   Function? suffixPressed,
}
    )=>TextFormField(
  controller: controller,
  //obscureText: true,
  keyboardType: keyType,
  onFieldSubmitted: (s)
  {
    onSubmitted(s);
  },


  validator: (s){
    validate(s);
  },



  decoration: InputDecoration(
    labelText: label,
    border: OutlineInputBorder(),
    prefixIcon: Icon(
        prefix,
    ),
    suffixIcon: MaterialButton(
      onPressed: ()
      {
        suffixPressed!();
      },
      child: Icon(
        suffix,
      ),
    ),

  ),
);
Widget buildTaskItem(Map model,context)=>Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 35.0,
          child: Text(
            "${model['time']}",
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${model['title']}",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                ),
              ),
              Text(
                " ${model['date ']}",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        IconButton(
            onPressed: ()
            {
              AppCubit.get(context).updateDatabase(status: "done", id: model["id"]);
            },
            icon: Icon(
              Icons.check_box,
              color: Colors.green,
            ),
        ),
        IconButton(
          onPressed: ()
          {
            AppCubit.get(context).updateDatabase(status: "Archive", id: model["id"]);

          },
          icon: Icon(
            Icons.archive,
            color: Colors.grey,
          ),
        ),

      ],
    ),

  ),
  onDismissed: (direction)
  {
AppCubit.get(context).deleteDatabase(id: model['id']);
  },
);
Widget tasksBuilder({
  required List<Map> tasks,
})=>ConditionalBuilder(
  condition: tasks.length>0,
  builder: (context)=>ListView.separated(
      itemBuilder: (context,index)=>buildTaskItem(tasks[index],context),
      separatorBuilder:  (context,index)=>myDivider(),
      itemCount: tasks.length),
  fallback:(context)=> Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Icon(
          Icons.menu,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          "No Tasks Yet, Please Add Some Tasks",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
);
Widget myDivider()=>Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey[300],
);
Widget buildArticleItem(article,context)=>InkWell(
  onTap: ()
  {
     navigateTo(context, WebViewScreen(article['url']));
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          height: 120.0,
          width: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
            image:DecorationImage(
              image: NetworkImage("${article["urlToImage"]}"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "${article['title']}",
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "${article['publishedAt']}",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);
Widget articleBuilder(list,context,{isSearch =false})=>ConditionalBuilder(
  condition: list.length>0 ,
  builder: (context)=> ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder:(context,index)=>buildArticleItem(list[index],context) ,
    separatorBuilder:(context,index)=>myDivider() ,
    itemCount: 10,
  ),
  fallback: (context)=> isSearch ? Container() : Center(child: CircularProgressIndicator()),
);
void navigateTo(context, widget)=>Navigator.push(context,
  MaterialPageRoute(
    builder: (context)=>widget,

    ),
  );
void navigateAndFinish(context, widget)=>Navigator.pushAndRemoveUntil(context,
  MaterialPageRoute(
    builder: (context)=>widget,

  ),
    (Route<dynamic> route )=>false

);
void showToast({
  required String message,
  required ToastsState state,
})
{
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );

}
enum ToastsState{SUCCESS,ERORR,WARNING}
Color chooseToastColor(ToastsState state)
{
  Color? color;
  switch(state)
  {
    case ToastsState.SUCCESS:
      color =Colors.green;
      break;
      
    case ToastsState.ERORR:
      color =Colors.red;
      break;
      
    case ToastsState.WARNING:
      color =Colors.amber;
      break;
      // TODO: Handle this case.
  }


  return color;
}

Widget buildListProduct( model,context,{bool? isSearch =true})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children: [

        Stack(
            alignment: AlignmentDirectional.bottomStart,
            children:
            [
              Image(
                image: NetworkImage("${model?.image}"),
                width: 120.0,
                fit: BoxFit.cover,
                height: 120.0,
              ),
              if(model?.discount !=0&& isSearch==true)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5.0,),
                  child: Text(
                    "${model?.discount}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8.0,
                    ),
                  ),
                )
            ]
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model?.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,

                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      "${model?.price}",


                      style: TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    if(model?.discount!=0&& isSearch ==true)
                      Text(
                        "${model?.old_price}",

                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: ()
                        {
                          ShopCupit.get(context).changeFavorites(model!.id!);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:  ShopCupit.get(context).favorites[model?.id] ==true? defaultColor :Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 14.0,),
                        )
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);


