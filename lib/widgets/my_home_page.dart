import 'package:flutter/material.dart';
import 'package:task_manager_app/models/project.dart';
import 'package:task_manager_app/models/task.dart';
import 'package:task_manager_app/services/project_service.dart';
import 'package:task_manager_app/services/task_service.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final ProjectService projectService = ProjectService();
  final TaskService taskService = TaskService();

  Future<List<Task>> loadTasks() async {
    List<Project> projects = await projectService.getProjects();
    List<Task> tasks = await taskService.getTasks(projects);
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager App'),
      ),
      body: FutureBuilder<List<Task>>(
        future: loadTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final tasks = snapshot.data ?? [];

          if (tasks.isEmpty) {
            return const Center(
              child: Text('Aucune tâche trouvée'),
            );
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              Task task = tasks[index];

              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description ?? 'Pas de description'),
              );
            },
          );
        },
      ),
    );
  }
}