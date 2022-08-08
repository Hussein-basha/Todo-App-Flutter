import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/archive_tasks/archived_tasks_screen.dart';
import 'package:todo_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_app/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/components/constants.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..createDatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (BuildContext context, AppStates state) {
              if (state is AppInsertDatabaseState) {
                Navigator.pop(context);
              }
            },
            builder: (BuildContext context, AppStates state) {
              AppCubit cubit = AppCubit.get(context);
              return Scaffold(
                key: scaffoldkey,
                appBar: AppBar(
                  backgroundColor: Colors.deepPurple,
                  title: Text(
                    cubit.titles[cubit.currentIndex],
                  ),
                ),
                body: ConditionalBuilder(
                  condition: state is! AppGetDatabaseLoadingState,
                  builder: (context) => cubit.screens[cubit.currentIndex],
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator()),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    if (cubit.isBottomSheetShow) {
                      if (formkey.currentState!.validate()) {
                        cubit.insertToDatabase(
                          title: titleController.text,
                          time: timeController.text,
                          date: dateController.text,
                        );
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
                                      validate: (String? value) {
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
                                      },
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
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
                                      label: 'Task Date',
                                      onChange: (String? value) {},
                                      onSubmit: (String? value) {},
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.parse(
                                              '2022-10-05'),
                                        ).then((value) {
                                          dateController.text =
                                              DateFormat.yMMMd().format(value!);
                                        });
                                      },
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
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
                        cubit.ChangeBottomSheetState(
                          isShow: false,
                          icon: Icons.edit,
                        );
                      });
                      cubit.ChangeBottomSheetState(
                        isShow: true,
                        icon: Icons.add,
                      );
                    }
                  },
                  child: Icon(
                    cubit.fabIcon,
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: cubit.currentIndex,
                  backgroundColor: Colors.blueGrey,
                  onTap: (index) {
                    cubit.changeIndex(index);
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
        )
    );
  }
}

