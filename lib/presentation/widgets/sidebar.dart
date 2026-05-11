import 'package:flutter/material.dart';
import 'package:task_manager_app/domain/entities/project.dart';

class Sidebar extends StatelessWidget {
  final List<Project> projects;

  const Sidebar({
    super.key,
    required this.projects,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: Colors.grey.shade100,
      child: Column(
        children: [
          const SizedBox(height: 24),
          const ListTile(
            leading: Icon(Icons.check_circle_outline),
            title: Text('Mes taches'),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.folder),
            title: Text('Projets'),
          ),
          const ListTile(
            leading: Icon(Icons.today_outlined),
            title: Text("Aujourd'hui"),
          ),
          const ListTile(
            leading: Icon(Icons.calendar_month_outlined),
            title: Text('Semaine'),
          ),
          const ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('Parametres'),
          ),
          
          
        ],
      ),
    );
  }
}
