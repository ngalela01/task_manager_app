import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/application/providers/project_notifier.dart';
import 'package:task_manager_app/domain/entities/project.dart';

Future<void> showProjectFormDialog(
  BuildContext context,
  WidgetRef ref, {
  Project? project,
}) async {
  final nameController = TextEditingController(text: project?.name ?? '');
  var selectedColor = project?.colorValue ?? 0xFF2196F3;

  final colors = <int>[
    0xFF2196F3,
    0xFF4CAF50,
    0xFFFF5722,
  ];

  final savedProject = await showDialog<Project>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text(project == null ? 'Nouveau projet' : 'Modifier projet'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nom'),
                ),
                const SizedBox(height: 16),
                Row(
                  children: colors.map((colorValue) {
                    final isSelected = selectedColor == colorValue;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: () {
                          setDialogState(() {
                            selectedColor = colorValue;
                          });
                        },
                        child: CircleAvatar(
                          radius: isSelected ? 14 : 12,
                          backgroundColor: Color(colorValue),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Annuler'),
              ),
              FilledButton(
                onPressed: () {
                  final name = nameController.text.trim();

                  if (name.isEmpty) {
                    return;
                  }

                  final newProject = project == null
                      ? Project(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: name,
                          colorValue: selectedColor,
                          createdAt: DateTime.now(),
                        )
                      : project.copyWith(
                          name: name,
                          colorValue: selectedColor,
                        );

                  Navigator.of(context).pop(newProject);
                },
                child: Text(project == null ? 'Creer' : 'Modifier'),
              ),
            ],
          );
        },
      );
    },
  );

  nameController.dispose();

  if (savedProject == null) {
    return;
  }

  if (project == null) {
    await ref.read(projectNotifierProvider.notifier).addProject(savedProject);
  } else {
    await ref.read(projectNotifierProvider.notifier).updateProject(savedProject);
  }
}
