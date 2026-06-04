import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/application/providers/shared_preferences_provider.dart';
import 'package:task_manager_app/domain/repositories/project_repository.dart';
import 'package:task_manager_app/domain/repositories/task_repository.dart';
import 'package:task_manager_app/infrastructure/project_repository_shared_preferences.dart';
import 'package:task_manager_app/infrastructure/task_repository_shared_preferences.dart';

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ProjectRepositorySharedPreferences(prefs);
});

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return TaskRepositorySharedPreferences(prefs);
});
