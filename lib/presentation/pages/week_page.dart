import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/application/providers/task_filter_providers.dart';
import 'package:task_manager_app/presentation/widgets/task_list_view.dart';

@RoutePage()
class WeekPage extends ConsumerWidget {
  const WeekPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(weekTasksProvider);

    return tasksAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      data: (tasks) => TaskListView(
        tasks: tasks,
        emptyMessage: 'Aucune tache cette semaine',
      ),
    );
  }
}
