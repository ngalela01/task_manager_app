import 'package:flutter/material.dart';
import 'package:task_manager_app/domain/entities/task.dart';
import 'package:task_manager_app/presentation/widgets/task_card.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  const TaskList({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              const Text(
                'Toutes les taches',
                style: TextStyle(fontSize: 28),
              ),
              const SizedBox(width: 12),
              Chip(label: Text(tasks.length.toString())),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskCard(task: tasks[index]);
            },
          ),
        ),
      ],
    );
  }
}
