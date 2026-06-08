import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/application/providers/search_provider.dart';
import 'package:task_manager_app/application/providers/selected_project_provider.dart';
import 'package:task_manager_app/application/providers/task_notifier.dart';
import 'package:task_manager_app/domain/entities/task.dart';

final todayTasksProvider = Provider<AsyncValue<List<Task>>>((ref) {
  final tasksAsync = ref.watch(taskNotifierProvider);

  return tasksAsync.whenData((tasks) {
    final today = DateTime.now();

    return tasks.where((task) {
      final dueDate = task.dueDate;
      if (dueDate == null) return false;

      return dueDate.day == today.day &&
          dueDate.month == today.month &&
          dueDate.year == today.year;
    }).toList();
  });
});

final weekTasksProvider = Provider<AsyncValue<List<Task>>>((ref) {
  final tasksAsync = ref.watch(taskNotifierProvider);

  return tasksAsync.whenData((tasks) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7));

    return tasks.where((task) {
      final dueDate = task.dueDate;
      if (dueDate == null) return false;

      final taskDay = DateTime(dueDate.year, dueDate.month, dueDate.day);

      return !taskDay.isBefore(startOfWeek) && taskDay.isBefore(endOfWeek);
    }).toList();
  });
});

final searchedTasksProvider = Provider<AsyncValue<List<Task>>>((ref) {
  final tasksAsync = ref.watch(taskNotifierProvider);
  final searchTerm = ref.watch(searchTermProvider).toLowerCase();
  final selectedProjectId = ref.watch(selectedProjectIdProvider);

  return tasksAsync.whenData((tasks) {
    var filteredTasks = tasks;

    if (selectedProjectId != null) {
      filteredTasks = filteredTasks.where((task) {
        return task.projectId == selectedProjectId;
      }).toList();
    }

    if (searchTerm.isEmpty) {
      return filteredTasks;
    }

    return filteredTasks.where((task) {
      final title = task.title.toLowerCase();
      final description = task.description?.toLowerCase() ?? '';

      return title.contains(searchTerm) || description.contains(searchTerm);
    }).toList();
  });
});
