import 'package:assist_gui/features/task_manager/controller/task_manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/task_tile.dart';

class RunningTasksListTiles extends StatelessWidget {
  const RunningTasksListTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskManagerCubit, TaskManagerState>(
      builder: (context, state) {
        final cubit = context.read<TaskManagerCubit>();
        final tasks = cubit.pending;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return TaskTile(task: task);
          },
        );
      },
    );
  }
}
