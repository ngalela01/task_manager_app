import 'package:flutter/material.dart';
import 'package:task_manager_app/domain/entities/project.dart';
import 'package:task_manager_app/domain/repositories/project_repository.dart';

class ProjectRepositoryMemory implements ProjectRepository {
  @override
  Future<List<Project>> getProjects() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return [
      Project(id: '1', name: 'Travail', color: Colors.blue),
      Project(id: '2', name: 'Personnel', color: Colors.green),
      Project(id: '3', name: 'Courses', color: Colors.deepOrange),
    ];
  }
}
