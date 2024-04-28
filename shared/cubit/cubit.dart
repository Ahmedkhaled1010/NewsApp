import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled4/shared/cubit/states.dart';
import 'package:untitled4/shared/network/local/cache_helper.dart';

import '../../modules/todo_app/archive_tasks/ArchiveTask_screen.dart';
import '../../modules/todo_app/done_tasks/DoneTask_screen.dart';
import '../../modules/todo_app/new_tasks/newTask_screen.dart';
import '../components/constants.dart';


class AppCubit extends Cubit<AppStates>{
  AppCubit() :super(AppInitialState());
  static AppCubit get(context)=>BlocProvider.of(context);
  int current_index =0;
  bool isButtomShow =false;
  IconData fabIcon =Icons.edit;
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archiveTasks=[];

  var database;
  List<Widget > screen =  [
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchiveTaskScreen(),


  ];

  List<String> title =
  [
    "New task",
    "Done Task",
    "Archive Task",
  ];

void changeIndex(int index)
{
  current_index =index;
  emit(AppChangeBottomNavBarState());
}
  void createDatabase() 
  {
    database= openDatabase(
        'todx.db',
        version: 1,
        onCreate: (database,version)
        {
          print("database created");
          database.execute("CREATE TABLE TASKS(id INTEGER PRIMARY KEY, title STRING,date STRING,time STRING,status STRING)").then((value)
          {
            print("table created");
          }).catchError((onError)
          {
            print("Error when creating ${onError.toString()}");
          });

        },
        onOpen: (database)
        {
          getDatabase(database);
          print("data base is opened");
        }
    ).then((value) 
    {
      database =value;
      emit(AppCreateDatabaseState());
    });
  }
   insertDatabase({
    required String title,
    required String date,
    required String time,
  }) async
  {
     await database.transaction((txn)
    {
      txn.rawInsert("INSERT INTO TASKS(title,date,time,status) VALUES('${title}','${date}','${time}','new')"
      ).then((value)

      {
        print("${value} inserted successfuly");
        emit(AppInsertDatabaseState());
        getDatabase(database);

      }).catchError((onError)
      {
        print("Error when creating ${onError.toString()}");
      }
      );
      return  Future(() => null);
    }
    );

  }
  void getDatabase(database)
  {
    newTasks=[];
    archiveTasks=[];
    doneTasks=[];

    emit(AppGetDatabaseLoadingState());
    database.rawQuery("SELECT * FROM TASKS").then(
            (value)
        {

          value.forEach((element)
          {
            if(element['status'] == 'new')
              {
                newTasks.add(element);
              }
            else if(element['status'] == 'done')
            {
             doneTasks.add(element);
            }
            else
            {
              archiveTasks.add(element);
            }
            print(element['status']);
          });
          emit(AppGetDatabaseState());
        });

  }
  void changeBottomSheetState({
    required bool isShow,
    required IconData icon
})
  {
    isButtomShow =isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());

  }
  void updateDatabase({
    required String status,
    required int id,
}) async
  {
      database.rawUpdate(
      "UPDATE TASKS SET status=? WHERE id =?",
        ["${status}","${id}"],
    ).then((value){
        getDatabase(database);
      emit(AppUpdateDatabaseLoadingState());
    });
  }
  void deleteDatabase({

    required int id,
  }) async
  {
    database.rawUpdate(
      "DELETE FROM TASKS  WHERE id =?",
      ["${id}"],
    ).then((value){
      getDatabase(database);
      emit(AppDeleteDatabaseLoadingState());
    });
  }
  bool isDark =false;

  void changeAppMode( [bool? change])

  {
    if(change!=null)
      {
        isDark=change;
        emit(NewsAppChangeModeState());

      }
    else
    {
      isDark = !isDark;
      print("change");
      CacheHelper.putData(key: "isDark", value: isDark).then((value)
      {
        emit(NewsAppChangeModeState());
      });

    }


  }
}
