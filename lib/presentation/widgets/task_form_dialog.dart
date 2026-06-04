import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/application/providers/project_notifier.dart';
import 'package:task_manager_app/application/providers/task_notifier.dart';
import 'package:task_manager_app/domain/entities/task.dart';
import 'package:task_manager_app/domain/entities/task_priority.dart';
import 'package:task_manager_app/domain/entities/task_status.dart';

Future<void> showTaskFormDialog(
  BuildContext context,
  WidgetRef ref, {
  Task? task,
}) async {
  final titleController = TextEditingController(text: task?.title ?? '');
  final descriptionController = TextEditingController(
    text: task?.description ?? '',
  );
  final projects = await ref.read(projectNotifierProvider.future);

  if (!context.mounted) {
    return;
  }

  var selectedPriority = task?.priority ?? TaskPriority.moyenne;
  var selectedStatus = task?.status ?? TaskStatus.afaire;
  String? selectedProjectId = task?.projectId;
  DateTime? selectedDueDate = task?.dueDate;

  final savedTask = await showDialog<Task>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text(task == null ? 'Nouvelle tache' : 'Modifier la tache'),
            content: SizedBox(
              width: 360,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Titre'),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 2,
                    ),
                    DropdownButtonFormField<TaskPriority>(
                      initialValue: selectedPriority,
                      decoration: const InputDecoration(labelText: 'Priorite'),
                      items: TaskPriority.values.map((priority) {
                        return DropdownMenuItem(
                          value: priority,
                          child: Text(priority.label),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }

                        setDialogState(() {
                          selectedPriority = value;
                        });
                      },
                    ),
                    DropdownButtonFormField<TaskStatus>(
                      initialValue: selectedStatus,
                      decoration: const InputDecoration(labelText: 'Statut'),
                      items: TaskStatus.values.map((status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Text(status.label),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }

                        setDialogState(() {
                          selectedStatus = value;
                        });
                      },
                    ),
                    DropdownButtonFormField<String?>(
                      initialValue: selectedProjectId,
                      decoration: const InputDecoration(labelText: 'Projet'),
                      items: [
                        const DropdownMenuItem<String?>(
                          value: null,
                          child: Text('Aucun projet'),
                        ),
                        ...projects.map((project) {
                          return DropdownMenuItem<String?>(
                            value: project.id,
                            child: Text(project.name),
                          );
                        }),
                      ],
                      onChanged: (value) {
                        setDialogState(() {
                          selectedProjectId = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDueDate ?? DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2035),
                          );

                          if (pickedDate == null || !context.mounted) {
                            return;
                          }

                          setDialogState(() {
                            selectedDueDate = pickedDate;
                          });
                        },
                        icon: const Icon(Icons.calendar_today),
                        label: Text(
                          selectedDueDate == null
                              ? 'Choisir une date'
                              : _formatDate(selectedDueDate!),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Annuler'),
              ),
              FilledButton(
                onPressed: () {
                  final title = titleController.text.trim();
                  final description = descriptionController.text.trim();

                  if (title.isEmpty) {
                    return;
                  }

                  final newTask = task == null
                      ? Task(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          title: title,
                          description: description.isEmpty ? null : description,
                          priority: selectedPriority,
                          status: selectedStatus,
                          dueDate: selectedDueDate,
                          projectId: selectedProjectId,
                          createdAt: DateTime.now(),
                        )
                      : task.copyWith(
                          title: title,
                          description: description.isEmpty ? null : description,
                          priority: selectedPriority,
                          status: selectedStatus,
                          dueDate: selectedDueDate,
                          projectId: selectedProjectId,
                        );

                  Navigator.of(context).pop(newTask);
                },
                child: Text(task == null ? 'Creer' : 'Modifier'),
              ),
            ],
          );
        },
      );
    },
  );

  titleController.dispose();
  descriptionController.dispose();

  if (savedTask == null) {
    return;
  }

  if (task == null) {
    await ref.read(taskNotifierProvider.notifier).addTask(savedTask);
  } else {
    await ref.read(taskNotifierProvider.notifier).updateTask(savedTask);
  }
}

String _formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day/$month/${date.year}';
}
