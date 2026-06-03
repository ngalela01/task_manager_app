import 'package:task_manager_app/domain/entities/task_priority.dart';
import 'package:task_manager_app/domain/entities/project.dart';
import 'package:task_manager_app/domain/entities/task.dart';
import 'package:task_manager_app/domain/entities/task_status.dart';
import 'package:task_manager_app/domain/repositories/task_repository.dart';

class TaskRepositoryMemory implements TaskRepository {
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Preparer la presentation',
      description: 'Preparer les slides et la demo',
      priority: TaskPriority.haute,
      status: TaskStatus.enCours,
      dueDate: DateTime(2026, 4, 20),
      projectId: '1',
      createdAt: DateTime(2026, 4, 20),
    ),
    Task(
      id: '2',
      title: 'Faire les courses',
      description: 'Lait, pain, oeufs, fruits',
      priority: TaskPriority.basse,
      status: TaskStatus.afaire,
      dueDate: DateTime(2026, 4, 20),
      projectId: '3',
      createdAt: DateTime(2026, 4, 20),
    ),
    Task(
      id: '3',
      title: 'Corriger le bug #42',
      description: 'Corriger le bug de connexion signale par le client',
      priority: TaskPriority.urgente,
      status: TaskStatus.afaire,
      dueDate: DateTime(2026, 4, 21),
      projectId: '1',
      createdAt: DateTime(2026, 4, 20),
    ),
    Task(
      id: '4',
      title: 'Appeler le dentiste',
      priority: TaskPriority.moyenne,
      status: TaskStatus.afaire,
      dueDate: DateTime(2026, 4, 18),
      projectId: '2',
      createdAt: DateTime(2026, 4, 20),
    ),
    Task(
      id: '5',
      title: 'Ranger les photos',
      description: 'Trier et sauvegarder',
      priority: TaskPriority.basse,
      status: TaskStatus.terminee,
      projectId: '2',
      createdAt: DateTime(2026, 4, 20),
    ),
  ];

  @override
  Future<List<Task>> getTasks() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_tasks);
  }

  @override
  Future<Task?> getTaskById(String id) async {
    for (final task in _tasks) {
      if (task.id == id) {
        return task;
      }
    }

    return null;
  }

  @override
  Future<void> addTask(Task task) async {
    _tasks.add(task);
  }

  @override
  Future<void> updateTask(Task task) async {
    final index = _tasks.indexWhere((item) => item.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
  }

  List<Task> filterByStatus(List<Task> tasks, TaskStatus status) {
    return tasks.where((task) => task.status == status).toList();
  }

  List<Task> sortByPriority(List<Task> tasks) {
    final sortedTasks = List<Task>.from(tasks);
    sortedTasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));
    return sortedTasks;
  }

  List<Task> taskGroupByProject(List<Task> tasks, Project project) {
    return tasks.where((task) => task.projectId == project.id).toList();
  }

  List<Task> tasksForDay(List<Task> tasks, DateTime day) {
    return tasks
        .where(
          (task) =>
              task.dueDate != null &&
              task.dueDate!.day == day.day &&
              task.dueDate!.month == day.month &&
              task.dueDate!.year == day.year,
        )
        .toList();
  }

  List<Task> tasksForWeek(List<Task> tasks) {
    final today = DateTime.now();
    final endOfWeek = today.add(const Duration(days: 7));

    return tasks.where((task) {
      if (task.dueDate == null) {
        return false;
      }

      return task.dueDate!.isAfter(today) &&
          task.dueDate!.isBefore(endOfWeek);
    }).toList();
  }
}
