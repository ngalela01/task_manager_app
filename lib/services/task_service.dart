import 'package:task_manager_app/models/project.dart';
import 'package:task_manager_app/models/task.dart';

class TaskService {
  Future<List<Task>> getTasks(List<Project> projects) async {
    await Future.delayed(const Duration(seconds: 2));

    return [
      Task(
        id: '1',
        title: 'Task 1',
        description: 'Description for Task 1',
        priority: TaskPriority.haute,
        status: TaskStatus.afaire,
        dueDate: DateTime.now().add(const Duration(days: 3)),
        project: projects[0],
      ),
      Task(
        id: '2',
        title: 'Task 2',
        description: 'Description for Task 2',
        priority: TaskPriority.moyenne,
        status: TaskStatus.enCours,
        dueDate: DateTime.now().add(const Duration(days: 5)),
        project: projects[1],
      ),
      Task(
        id: '3',
        title: 'Task 3',
        description: 'Description for Task 3',
        priority: TaskPriority.basse,
        status: TaskStatus.terminee,
        dueDate: DateTime.now().add(const Duration(days: 7)),
        project: projects[0],
      ),
      Task(
        id: '4',
        title: 'Task 4',
        description: 'Description for Task 4',
        priority: TaskPriority.haute,
        status: TaskStatus.afaire,
        dueDate: DateTime.now().add(const Duration(days: 2)),
        project: projects[2],
      ),
      Task(
        id: '5',
        title: 'Task 5',
        description: 'Description for Task 5',
        priority: TaskPriority.moyenne,
        status: TaskStatus.enCours,
        dueDate: DateTime.now().add(const Duration(days: 4)),
        project: projects[1],
      ),
      Task(
        id: '6',
        title: 'Task 6',
        description: 'Description for Task 6',
        priority: TaskPriority.basse,
        status: TaskStatus.terminee,
        dueDate: DateTime.now().add(const Duration(days: 6)),
        project: projects[2],
      ),
      Task(
        id: '7',
        title: 'task7',
        description: 'description for Task 7',
        project: projects[1],
      ),
      Task(
        id: '8',
        title: 'task 8',
        description: 'description for Task 8',
        project: projects[1],
      ),
    ];
  }
}
