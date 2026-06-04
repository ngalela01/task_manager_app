import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/application/providers/repository_providers.dart';
import 'package:task_manager_app/domain/entities/project.dart';

class ProjectNotifier extends AsyncNotifier<List<Project>> {
  @override
  Future<List<Project>> build() async {
    final repository = ref.watch(projectRepositoryProvider);
    return repository.getProjects();
  }
  Future<void> _reloadProjects() async {
    final repository = ref.read(projectRepositoryProvider);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return repository.getProjects();
    });
  }

  Future<void> addProject(Project project) async {
    final repository = ref.read(projectRepositoryProvider);
    await repository.addProject(project);
    await _reloadProjects();
  }

  Future<void> updateProject(Project project) async {
    final repository = ref.read(projectRepositoryProvider);
    await repository.updateProject(project);
    await _reloadProjects();
  }

  Future<void> deleteProject(String id) async {
    final repository = ref.read(projectRepositoryProvider);
    await repository.deleteProject(id);
    await _reloadProjects();
  }
}
final projectNotifierProvider =
    AsyncNotifierProvider<ProjectNotifier, List<Project>>(
  ProjectNotifier.new,
);
