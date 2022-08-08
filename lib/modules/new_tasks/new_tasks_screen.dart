import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/components/constants.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class NewTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder:(BuildContext context ,AppStates state)
      {
        var tasks = AppCubit.get(context).newTasks;
        return tasksBuilder(
            tasks: tasks,
        );
      } ,
      listener:(BuildContext context ,AppStates state){} ,
    );
  }
}
