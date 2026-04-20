import 'package:flutter/material.dart';
import 'package:task_manager_app/models/project.dart';

class ProjectService {
  Future<List<Project>> getProjects() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      Project(id: '1', name: 'Project 1', color: Colors.blue),
      Project(id: '2', name: 'Project 2', color: Colors.red),
      Project(id: '3', name: 'Project 3', color: Colors.green),
    ];
  }
}
