import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager_app/application/providers/repository_providers.dart';

class ProjectSidebar extends ConsumerWidget {
  const ProjectSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsProvider);
    return SizedBox(
      width: 190,
      child: projectsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),

        data: (projects) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Projets',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(icon: const Icon(Icons.add), onPressed: () {}),
                  ],
                ),
              ),
              const ListTile(
                leading: Icon(Icons.list),
                title: Text('Toutes les taches'),
              ),
              const Divider(),
              ...projects.map(
                (project) => ListTile(
                  leading: CircleAvatar(
                    radius: 5,
                    backgroundColor: Color(project.colorValue),
                  ),
                  title: Text(project.name),
                  onTap: () {},
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
