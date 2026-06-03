import 'package:task_manager_app/domain/entities/project.dart';
import 'package:task_manager_app/domain/repositories/project_repository.dart';

class ProjectRepositoryMemory implements ProjectRepository {
  final List<Project> _projects = [
    Project(
      id: '1',
      name: 'Travail',
      colorValue: 0xFF2196F3,
      createdAt: DateTime(2026, 4, 20),
    ),
    Project(
      id: '2',
      name: 'Personnel',
      colorValue: 0xFF4CAF50,
      createdAt: DateTime(2026, 4, 20),
    ),
    Project(
      id: '3',
      name: 'Courses',
      colorValue: 0xFFFF5722,
      createdAt: DateTime(2026, 4, 20),
    ),
  ];

  @override
  Future<List<Project>> getProjects() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_projects);
  }

  @override
  Future<Project?> getProjectById(String id) async {
    for (final project in _projects) {
      if (project.id == id) {
        return project;
      }
    }

    return null;
  }

  @override
  Future<void> addProject(Project project) async {
    _projects.add(project);
  }

  @override
  Future<void> updateProject(Project project) async {
    final index = _projects.indexWhere((item) => item.id == project.id);
    if (index != -1) {
      _projects[index] = project;
    }
  }

  @override
  Future<void> deleteProject(String id) async {
    _projects.removeWhere((project) => project.id == id);
  }
}
