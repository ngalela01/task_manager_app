import 'package:task_manager_app/domain/entities/project.dart';
import 'package:task_manager_app/domain/entities/task.dart';
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
        title: 'Creer la structure du projet',
        description: 'Organiser les dossiers selon l architecture hexagonale',
        priority: TaskPriority.haute,
        status: TaskStatus.terminee,
        dueDate: DateTime.now(),
        project: projects[0],
      ),
      Task(
        id: '2',
        title: 'Creer les repositories',
        description: 'Definir les contrats dans le domaine',
        priority: TaskPriority.moyenne,
        status: TaskStatus.enCours,
        dueDate: DateTime.now().add(const Duration(days: 1)),
        project: projects[0],
      ),
      Task(
        id: '3',
        title: 'Preparer le formulaire',
        description: 'Ajouter une page pour creer une tache',
        priority: TaskPriority.basse,
        status: TaskStatus.afaire,
        dueDate: DateTime.now().add(const Duration(days: 3)),
        project: projects[1],
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
