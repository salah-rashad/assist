import 'package:assist_core/services/task_manager/task_event.dart';
import 'package:assist_gui/core/utils/extensions.dart';
import 'package:assist_gui/features/task_manager/controller/task_manager_cubit.dart';
import 'package:assist_gui/features/task_manager/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RunningTasksListTiles extends StatelessWidget {
  const RunningTasksListTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskManagerCubit, TaskEvent?>(
      builder: (context, state) {
        final cubit = context.read<TaskManagerCubit>();
        final tasks = cubit.pendingTasks;

        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 80,
            maxHeight: 200,
            minWidth: 200,
            maxWidth: 320,
          ),
          child: Builder(builder: (context) {
            if (tasks.isEmpty) {
              return Text(
                'No tasks running',
                style: context.textTheme.muted,
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskTile(task: task);
              },
            );
          }),
        );
      },
    );
  }
}
