import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/application/providers/repository_providers.dart';
import 'package:task_manager_app/domain/entities/task.dart';

class TaskNotifier extends AsyncNotifier<List<Task>> {
  @override
  Future<List<Task>> build() async {
    final repository = ref.watch(taskRepositoryProvider);
    return await repository.getTasks();
  }

  Future<void> _reloadTasks() async {
    final repository = ref.read(taskRepositoryProvider);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return repository.getTasks();
    });
  }

  Future<void> addTask(Task task) async {
    final repository = ref.read(taskRepositoryProvider);
    await repository.addTask(task);
    await _reloadTasks();
  }

  Future<void> updateTask(Task task) async {
    final repository = ref.read(taskRepositoryProvider);
    await repository.updateTask(task);
    await _reloadTasks();
  }

  Future<void> deleteTask(String id) async {
    final repository = ref.read(taskRepositoryProvider);
    await repository.deleteTask(id);
    await _reloadTasks();
  }
}

final taskNotifierProvider = AsyncNotifierProvider<TaskNotifier, List<Task>>(
  TaskNotifier.new,
);
