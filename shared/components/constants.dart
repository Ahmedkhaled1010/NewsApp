//GET https://newsapi.org/
// v2/everything?
// q=Apple&from=2023-12-16&sortBy=popularity&apiKey=


//https://newsapi.org/v2/everything?q=Apple&from=2023-12-16&sortBy=popularity&apiKey=API_KEY
import 'package:flutter/material.dart';

import '../../modules/shop_app/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signUp(context)

{
  CacheHelper.removeData(key: "token").then(
          (value)
      {
        if(value)
        {
          navigateAndFinish(context, ShopLoginScreen());
        }
      }
  );
}
void printFullText(String txt)
{
  final pattern =RegExp(".{1,800}");
  pattern.allMatches(txt).forEach((match)=>print(match.group(0)));
}

String? token ;
String? uid;