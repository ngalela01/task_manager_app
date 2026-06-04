import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/domain/entities/project.dart';
import 'package:task_manager_app/domain/repositories/project_repository.dart';

class ProjectRepositorySharedPreferences implements ProjectRepository {
  final SharedPreferences prefs;

  ProjectRepositorySharedPreferences(this.prefs);

  static const String _projectsKey = 'projects';

  List<Project> _defaultProjects() {
    return [
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
  }

  Future<List<Project>> _loadProjects() async {
    final jsonString = prefs.getString(_projectsKey);

    if (jsonString == null) {
      final projects = _defaultProjects();
      await _saveProjects(projects);
      return projects;
    }

    final jsonList = jsonDecode(jsonString) as List;

    return jsonList.map((json) {
      return Project.fromJson(json as Map<String, dynamic>);
    }).toList();
  }

  Future<void> _saveProjects(List<Project> projects) async {
    final jsonList = projects.map((project) => project.toJson()).toList();
    final jsonString = jsonEncode(jsonList);

    await prefs.setString(_projectsKey, jsonString);
  }

  @override
  Future<List<Project>> getProjects() async {
    return _loadProjects();
  }

  @override
  Future<Project?> getProjectById(String id) async {
    final projects = await _loadProjects();

    for (final project in projects) {
      if (project.id == id) {
        return project;
      }
    }

    return null;
  }

  @override
  Future<void> addProject(Project project) async {
    final projects = await _loadProjects();
    projects.add(project);
    await _saveProjects(projects);
  }

  @override
  Future<void> updateProject(Project project) async {
    final projects = await _loadProjects();
    final index = projects.indexWhere((item) => item.id == project.id);

    if (index != -1) {
      projects[index] = project;
      await _saveProjects(projects);
    }
  }

  @override
  Future<void> deleteProject(String id) async {
    final projects = await _loadProjects();
    projects.removeWhere((project) => project.id == id);
    await _saveProjects(projects);
  }
}