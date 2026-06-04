import 'package:flutter/material.dart';
import 'package:task_manager_app/domain/entities/task.dart';
import 'package:task_manager_app/presentation/widgets/task_card.dart';

class TaskListView extends StatelessWidget {
  final List<Task> tasks;
  final String emptyMessage;

  const TaskListView({
    super.key,
    required this.tasks,
    this.emptyMessage = 'Aucune tache pour le moment',
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Center(child: Text(emptyMessage));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskCard(task: tasks[index]);
      },
    );
  }
}
