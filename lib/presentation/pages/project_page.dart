import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/application/providers/search_provider.dart';
import 'package:task_manager_app/application/providers/search_visibility_provider.dart';
import 'package:task_manager_app/application/providers/task_filter_providers.dart';
import 'package:task_manager_app/presentation/widgets/task_form_dialog.dart';
import 'package:task_manager_app/presentation/widgets/task_list_view.dart';

@RoutePage()
class ProjectPage extends ConsumerWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(searchedTasksProvider);
    final searchVisible = ref.watch(searchVisibleProvider);

    return Scaffold(
      body: tasksAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        data: (tasks) => Column(
          children: [
            if (searchVisible)
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Rechercher une tache',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    ref.read(searchTermProvider.notifier).state = value;
                  },
                ),
              ),
            Expanded(
              child: TaskListView(
                tasks: tasks,
                emptyMessage: 'Aucune tache trouvee',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showTaskFormDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Nouvelle tache'),
      ),
    );
  }
}
