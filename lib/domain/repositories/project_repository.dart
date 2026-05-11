import 'package:task_manager_app/domain/entities/project.dart';

abstract class ProjectRepository {
  Future<List<Project>> getProjects();
}
