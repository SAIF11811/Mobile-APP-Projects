import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/components.dart';
import 'package:todo_app/cubit.dart';
import 'package:todo_app/states.dart';

class ArchivedTasksScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var tasks = AppCubit.get(context).archivedTasks;

        return tasksBuilder(
          tasks: tasks,
        );
      },
    );
  }
}