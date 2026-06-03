import 'package:task_manager_app/domain/entities/project.dart';

abstract class ProjectRepository {
  Future<List<Project>> getProjects();
  Future<Project?> getProjectById(String id);
  Future<void> addProject(Project project);
  Future<void> updateProject(Project project);
  Future<void> deleteProject(String id);
}
