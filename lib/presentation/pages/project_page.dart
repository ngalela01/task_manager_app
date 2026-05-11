import 'package:flutter/material.dart';
import 'package:task_manager_app/domain/entities/task.dart';
import 'package:task_manager_app/domain/repositories/task_repository.dart';
import 'package:task_manager_app/infrastructure/task_repository_memory.dart';
import 'package:task_manager_app/presentation/widgets/task_list.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final TaskRepository taskRepository = TaskRepositoryMemory();
  late final Future<List<Task>> tasksFuture;

  @override
  void initState() {
    super.initState();
    tasksFuture = taskRepository.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Task>>(
        future: tasksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Erreur lors du chargement des taches'),
            );
          }

          final tasks = snapshot.data ?? [];

          if (tasks.isEmpty) {
            return const Center(child: Text('Aucune tache pour le moment'));
          }

          return TaskList(tasks: tasks);
        },
      ),
    );
  }
}
