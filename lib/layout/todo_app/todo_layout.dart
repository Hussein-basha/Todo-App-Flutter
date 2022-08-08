import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/modules/archive_tasks/archived_tasks_screen.dart';
import 'package:todo_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_app/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/components/constants.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayoutApp extends StatefulWidget {
  const HomeLayoutApp({Key? key}) : super(key: key);

  @override
  State<HomeLayoutApp> createState() => _HomeLayoutStateState();
}

class _HomeLayoutStateState extends State<HomeLayoutApp> {
  int currentIndex = 0;
  Database? database;
  bool isBottomSheetShow = false;
  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  List<Widget> screens = [
    NewTasksScreen(),
    doneTasksScreen(),
    archivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          titles[currentIndex],
        ),
      ),
      body:ConditionalBuilder(
        condition:  true,
        //condition:tasks.length > 0,
        builder:(context) => screens[currentIndex],
        fallback:(context) => Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isBottomSheetShow) {
            if (formkey.currentState!.validate()) {
              insertToDatabase(
                title: titleController.text,
                time: timeController.text,
                date: dateController.text,
              ).then((value) {
                Navigator.pop(context);
                isBottomSheetShow = false;
                setState(() {
                  fabIcon = Icons.edit;
                });
              }).catchError((error) {
                print(
                    'Error When Inserting Title,time,date  ${error.toString()}');
              });
            }
          } else {
            scaffoldkey.currentState!.showBottomSheet(
                  (context) => Container(
                color: Colors.grey[100],
                padding: const EdgeInsets.all(
                  20.0,
                ),
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      defaultFormField(
                        controller: titleController,
                        onTap: () {},
                        onChange: (String? value) {},
                        onSubmit: (String? value) {},
                        type: TextInputType.text,
                        label: 'Task Title',
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Title Must Not Be Empty';
                          }
                          return null;
                        },
                        prefix: Icons.title,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultFormField(
                        controller: timeController,
                        type: TextInputType.datetime,
                        label: 'Task Time',
                        onChange: (String? value) {},
                        onSubmit: (String? value) {},
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            timeController.text =
                                value!.format(context).toString();
                            print(value.format(context));
                          });
                          //print('Timing Tapped');
                        },
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Time Must Not Be Empty';
                          }
                          return null;
                        },
                        prefix: Icons.watch_later_outlined,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defaultFormField(
                        controller: dateController,
                        type: TextInputType.datetime,
                        //isClickable: false,
                        label: 'Task Date',
                        onChange: (String? value) {},
                        onSubmit: (String? value) {},
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2022-10-05'),
                          ).then((value) {
                            //print(DateFormat.yMMMd().format(value!));
                            dateController.text =
                                DateFormat.yMMMd().format(value!);
                          });
                        },
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Date Must Not Be Empty';
                          }
                          return null;
                        },
                        prefix: Icons.calendar_today,
                      ),
                    ],
                  ),
                ),
              ),
              elevation: 20.0,
            ).closed.then((value) {
              //Navigator.pop(context);
              isBottomSheetShow = false;
              setState(() {
                fabIcon = Icons.edit;
              });
            });
            isBottomSheetShow = true;
            setState(() {
              fabIcon = Icons.add;
            });
          }

          // try{
          //   var name = await getName();
          //   print(name);
          //
          //   throw ('Error !!!!!!!');
          // }catch(error){
          //   print('Error ${error.toString()}');
          // }

          // getName().then((value)
          // {
          //   print(value);
          //   print('Hussein');
          //   //throw('Error !!!!!!!!!');
          // }).catchError((error)
          // {
          //   print('Error Is ${error.toString()}');
          // });

          //insertToDatabase();
        },
        child: Icon(
          fabIcon,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor: Colors.blueGrey,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
            ),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_circle_outline,
            ),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive_outlined,
            ),
            label: 'Archived',
          ),
        ],
      ),
    );
  }
  Future<String> getName() async {
    return 'Hussein Basha';
  }

  void createDatabase() async {
    database = await openDatabase(
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
        getDataFromDatabase(database).then((value) {
          Navigator.pop(context);
          setState(() {
            isBottomSheetShow = false;
            fabIcon = Icons.edit;
            //tasks = value;
            //print(tasks);
          });
        });
        print('Database Opened');
      },
    );
  }

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database!.transaction((txn) async {
      txn
          .rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print('$value Inserted Successfully');
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database!.rawQuery('SELECT * FROM tasks');
  }
}