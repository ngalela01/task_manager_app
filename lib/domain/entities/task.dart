import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_manager_app/domain/entities/task_priority.dart';
import 'package:task_manager_app/domain/entities/task_status.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
abstract class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    String? description,
    @Default(TaskPriority.moyenne) TaskPriority priority,
    @Default(TaskStatus.afaire) TaskStatus status,
    DateTime? dueDate,
    String? projectId,
    required DateTime createdAt,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) =>
      _$TaskFromJson(json);
}