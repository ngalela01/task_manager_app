import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/application/providers/repository_providers.dart';
import 'package:task_manager_app/application/providers/task_notifier.dart';
import 'package:task_manager_app/domain/entities/task.dart';

class TaskCard extends ConsumerWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsProvider);
    Color? projectColor;

    projectsAsync.whenData((projects) {
      for (final project in projects) {
        if (project.id == task.projectId) {
          projectColor = Color(project.colorValue);
        }
      }
    });

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
                  Row(
                    children: [
                      if (projectColor != null) ...[
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: projectColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Expanded(child: Text(task.title)),
                    ],
                  ),
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
                  onPressed: () => _confirmDelete(context, ref),
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Supprimer la tache'),
          content: Text('Veux-tu supprimer "${task.title}" ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Annuler'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Supprimer'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    await ref.read(taskNotifierProvider.notifier).deleteTask(task.id);
  }
}
