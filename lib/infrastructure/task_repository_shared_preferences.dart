import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/domain/entities/task.dart';
import 'package:task_manager_app/domain/entities/task_priority.dart';
import 'package:task_manager_app/domain/entities/task_status.dart';
import 'package:task_manager_app/domain/repositories/task_repository.dart';

class TaskRepositorySharedPreferences implements TaskRepository {
  final SharedPreferences prefs;

  TaskRepositorySharedPreferences(this.prefs);

  static const String _tasksKey = 'tasks';
  static const String _tasksSeededKey = 'tasksSeeded';

  List<Task> _defaultTasks() {
    return [
      Task(
        id: '1',
        title: 'Preparer la presentation',
        description: 'Preparer les slides et la demo',
        priority: TaskPriority.haute,
        status: TaskStatus.enCours,
        dueDate: DateTime(2026, 4, 20),
        projectId: '1',
        createdAt: DateTime(2026, 4, 20),
      ),
      Task(
        id: '2',
        title: 'Faire les courses',
        description: 'Lait, pain, oeufs, fruits',
        priority: TaskPriority.basse,
        status: TaskStatus.afaire,
        dueDate: DateTime(2026, 4, 20),
        projectId: '3',
        createdAt: DateTime(2026, 4, 20),
      ),
    ];
  }

  Future<List<Task>> _loadTasks() async {
    final jsonString = prefs.getString(_tasksKey);
    final tasksSeeded = prefs.getBool(_tasksSeededKey) ?? false;

    if (jsonString == null && !tasksSeeded) {
      final tasks = _defaultTasks();
      await _saveTasks(tasks);
      await prefs.setBool(_tasksSeededKey, true);
      return tasks;
    }

    if (!tasksSeeded) {
      await prefs.setBool(_tasksSeededKey, true);
    }

    if (jsonString == null) {
      return [];
    }

    final jsonList = jsonDecode(jsonString) as List;

    return jsonList.map((json) {
      return Task.fromJson(json as Map<String, dynamic>);
    }).toList();
  }

  Future<void> _saveTasks(List<Task> tasks) async {
    final jsonList = tasks.map((task) => task.toJson()).toList();
    final jsonString = jsonEncode(jsonList);

    await prefs.setString(_tasksKey, jsonString);
  }

  @override
  Future<List<Task>> getTasks() async {
    return _loadTasks();
  }

  @override
  Future<Task?> getTaskById(String id) async {
    final tasks = await _loadTasks();

    for (final task in tasks) {
      if (task.id == id) {
        return task;
      }
    }

    return null;
  }

  @override
  Future<void> addTask(Task task) async {
    final tasks = await _loadTasks();
    tasks.add(task);
    await _saveTasks(tasks);
  }

  @override
  Future<void> updateTask(Task task) async {
    final tasks = await _loadTasks();
    final index = tasks.indexWhere((item) => item.id == task.id);

    if (index != -1) {
      tasks[index] = task;
      await _saveTasks(tasks);
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    final tasks = await _loadTasks();
    tasks.removeWhere((task) => task.id == id);
    await _saveTasks(tasks);
  }
}
