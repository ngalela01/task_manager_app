import 'package:flutter/material.dart';
import 'package:task_manager_app/models/task.dart';
import 'package:task_manager_app/services/task_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskService taskService = TaskService();
  Future<List<Task>> loadTasks() async {
    return await taskService.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    List tasks = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
      ),
      body: FutureBuilder(
      future: loadTasks(),
      builder: (context, snapshot) {
        tasks = snapshot.data ?? [];

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erreur lors du chargement des taches');
        } else {
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              Task task = tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description ?? ''),
                trailing: Text(
                  task.status.label,
                  style: TextStyle(color: task.status.textColor),
                ),
              );
            },
          );
        }
      },
    )

    );
  }
}
