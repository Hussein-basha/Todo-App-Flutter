import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:todo_app/layoyt/news_app/cubit/states.dart';
import 'package:todo_app/modules/archive_tasks/archived_tasks_screen.dart';
import 'package:todo_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_app/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  bool isBottomSheetShow = false;
  IconData fabIcon = Icons.edit;
  List<Widget> screens = [
    NewTasksScreen(),
    doneTasksScreen(),
    archivedTasksScreen(),
  ];
  List<String> titles =
  [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index)
  {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }
  Future<String> getName() async {
    return 'Hussein Basha';
  }

  void createDatabase() async {
    openDatabase(
      'Todo.db',
      version: 1,
      onCreate: (database, version) {
        print('Database Created');
        database
            .execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT , status TEXT )')
            .then(
              (value) {
            print('Table Created');
          },
        ).catchError((erroe) {
          print('Error When Creating Table ${erroe.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('Database Opened');
      },
    ).then((value)
    {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

   insertToDatabase({
    required String title,
    required String time,
    required String date,
     //String? status,
  }) async {
     await database!.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")',
      ).then((value) {
        print('$value Inserted Successfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database)  {
    emit(AppGetDatabaseLoadingState());
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
     database!.rawQuery('SELECT * FROM tasks').then((value)
     {
       value.forEach((element) {
         if(element['status'] == 'new') {
           newTasks.add(element);
         }
         else if(element['status'] == 'done') {
           doneTasks.add(element);
         }
         else {
           archivedTasks.add(element);
         }
       });
       emit(AppGetDatabaseState());
     });
  }

  void updateData({
    required String status,
    required int id,
}) async
  {
    // Update some record
       database!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status',id],
    ).then((value)
     {
       getDataFromDatabase(database);
       emit(AppUpdateDatabaseState());
     });
    //print('updated: $count');
  }

  void deleteData({
     String? status,
    required int id,
  }) async
  {
    // Update some record
    database!.rawDelete(
      'DELETE FROM tasks WHERE id = ?', [id],
    ).then((value)
    {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
    //print('Delete: $count');
  }


  void ChangeBottomSheetState({
  required bool isShow,
    required IconData icon,
})
  {
    isBottomSheetShow = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }


}