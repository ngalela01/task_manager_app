import 'package:flutter/material.dart';

class Project {
  final String id;
  final String name;
  final Color color;

  Project({required this.id, required this.name, required this.color});

  Project copyWith({String? id, String? name, Color? color}) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  @override
  String toString() {
    return 'Project(id: $id, name: $name, color: $color)';
  }
}
