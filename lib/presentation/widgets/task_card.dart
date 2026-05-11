import 'package:flutter/material.dart';
import 'package:task_manager_app/domain/entities/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title),
                  if ((task.description ?? '').isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(task.description!),
                  ],
                  const SizedBox(height: 12),
                  Chip(label: Text(task.priority.label)),
                ],
              ),
            ),
            Column(
              children: [
                Chip(
                  label: Text(task.status.label),
                  labelStyle: TextStyle(color: task.status.textColor),
                ),
                const SizedBox(height: 24),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
