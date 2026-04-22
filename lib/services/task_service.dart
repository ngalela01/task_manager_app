import 'package:task_manager_app/models/project.dart';
import 'package:task_manager_app/models/task.dart';
import 'package:task_manager_app/services/project_service.dart';

class TaskService {
  Future<List<Task>> getTasks() async {
    ProjectService projectService = ProjectService();
    List<Project> projects = await projectService.getProjects();
    await Future.delayed(const Duration(seconds: 1));

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

  List<Task> filterByStatus(List<Task> tasks, TaskStatus status) {
    return tasks.where((task) => task.status == status).toList();
  }

  List<Task> sortByPriority(List<Task> tasks) {
    final sortedTasks = List<Task>.from(tasks);
    sortedTasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));
    return sortedTasks;
  }

  List<Task> taskGroupByProject(List<Task> tasks, Project projet) {
    return tasks.where((task)=> task.project?.id == projet.id).toList();
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

    return task.dueDate!.isAfter(today) && task.dueDate!.isBefore(endOfWeek);
  }).toList();
}

}
