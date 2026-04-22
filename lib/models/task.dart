import 'package:flutter/material.dart';
import 'package:task_manager_app/models/project.dart';

enum TaskPriority { basse, moyenne, haute, urgente }

enum TaskStatus {
  afaire,
  enCours,
  terminee;

  String get label {
    switch (this) {
      case TaskStatus.afaire:
        return 'A faire';
      case TaskStatus.enCours:
        return 'En cours';
      case TaskStatus.terminee:
        return 'Terminée';
    }
  }

  Color get textColor {
    switch (this) {
      case TaskStatus.afaire:
        return Colors.orange;
      case TaskStatus.enCours:
        return Colors.blue;
      case TaskStatus.terminee:
        return Colors.green;
    }
  }
}

class Task {
  final String id;
  final String title;
  final String? description;
  final TaskPriority priority;
  final TaskStatus status;
  final DateTime? dueDate;
  final Project? project;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.priority = TaskPriority.moyenne,
    this.status = TaskStatus.enCours,
    this.dueDate,
    this.project,
    createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Task copyWith({
    String? id,
    String? title,
    String? description,
    TaskPriority? priority,
    TaskStatus? status,
    DateTime? dueDate,
    Project? project,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      project: project ?? this.project,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, description: $description, priority: $priority, status: $status, dueDate: $dueDate, project: $project, createdAt: $createdAt)';
  }
}
