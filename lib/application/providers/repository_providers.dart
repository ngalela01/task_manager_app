import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/domain/repositories/project_repository.dart';
import 'package:task_manager_app/domain/repositories/task_repository.dart';
import 'package:task_manager_app/infrastructure/project_repository_memory.dart';
import 'package:task_manager_app/infrastructure/task_repository_memory.dart';

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  return ProjectRepositoryMemory();
});

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepositoryMemory();
});

final projectsProvider = FutureProvider((ref) async {
  final repository = ref.watch(projectRepositoryProvider);
  return repository.getProjects();
});

final tasksProvider = FutureProvider((ref) async {
  final repository = ref.watch(taskRepositoryProvider);
  return repository.getTasks();
});