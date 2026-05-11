import 'package:task_manager_app/domain/entities/priority.dart';
import 'package:task_manager_app/domain/entities/project.dart';
import 'package:task_manager_app/domain/entities/task.dart';
import 'package:task_manager_app/domain/entities/task_status.dart';
import 'package:task_manager_app/domain/repositories/task_repository.dart';
import 'package:task_manager_app/infrastructure/project_repository_memory.dart';

class TaskRepositoryMemory implements TaskRepository {
  final ProjectRepositoryMemory projectRepository;

  TaskRepositoryMemory({ProjectRepositoryMemory? projectRepository})
      : projectRepository = projectRepository ?? ProjectRepositoryMemory();

  @override
  Future<List<Task>> getTasks() async {
    final projects = await projectRepository.getProjects();
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      Task(
        id: '1',
        title: 'Preparer la presentation',
        description: 'Preparer les slides et la demo',
        priority: TaskPriority.haute,
        status: TaskStatus.enCours,
        dueDate: DateTime(2026, 4, 20),
        project: projects[0],
      ),
      Task(
        id: '2',
        title: 'Faire les courses',
        description: 'Lait, pain, oeufs, fruits',
        priority: TaskPriority.basse,
        status: TaskStatus.afaire,
        dueDate: DateTime(2026, 4, 20),
        project: projects[2],
      ),
      Task(
        id: '3',
        title: 'Corriger le bug #42',
        description: 'Corriger le bug de connexion signale par le client',
        priority: TaskPriority.urgente,
        status: TaskStatus.afaire,
        dueDate: DateTime(2026, 4, 21),
        project: projects[0],
      ),
      Task(
        id: '4',
        title: 'Appeler le dentiste',
        description: '',
        priority: TaskPriority.moyenne,
        status: TaskStatus.afaire,
        dueDate: DateTime(2026, 4, 18),
        project: projects[1],
      ),
      Task(
        id: '5',
        title: 'Ranger les photos',
        description: 'Trier et sauvegarder',
        priority: TaskPriority.basse,
        status: TaskStatus.terminee,
        project: projects[1],
      ),
      Task(
        id: '6',
        title: 'Lire le TP2',
        description: 'Comprendre sidebar, formulaires et widgets',
        priority: TaskPriority.moyenne,
        status: TaskStatus.enCours,
        dueDate: DateTime(2026, 4, 19),
        project: projects[0],
      ),
      Task(
        id: '7',
        title: 'Creer ProjectRepository',
        description: 'Ajouter le contrat dans domain/repositories',
        priority: TaskPriority.haute,
        status: TaskStatus.terminee,
        project: projects[0],
      ),
    ];
  }

  @override
  Future<Task> getTaskById(String id) async {
    final tasks = await getTasks();
    return tasks.firstWhere((task) => task.id == id);
  }

  @override
  Future<void> addTask(Task task) async {}

  @override
  Future<void> updateTask(Task task) async {}

  @override
  Future<void> deleteTask(String id) async {}

  List<Task> filterByStatus(List<Task> tasks, TaskStatus status) {
    return tasks.where((task) => task.status == status).toList();
  }

  List<Task> sortByPriority(List<Task> tasks) {
    final sortedTasks = List<Task>.from(tasks);
    sortedTasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));
    return sortedTasks;
  }

  List<Task> taskGroupByProject(List<Task> tasks, Project projet) {
    return tasks.where((task) => task.project?.id == projet.id).toList();
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
