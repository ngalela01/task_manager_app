// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  priority:
      $enumDecodeNullable(_$TaskPriorityEnumMap, json['priority']) ??
      TaskPriority.moyenne,
  status:
      $enumDecodeNullable(_$TaskStatusEnumMap, json['status']) ??
      TaskStatus.afaire,
  dueDate: json['dueDate'] == null
      ? null
      : DateTime.parse(json['dueDate'] as String),
  projectId: json['projectId'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'priority': _$TaskPriorityEnumMap[instance.priority]!,
  'status': _$TaskStatusEnumMap[instance.status]!,
  'dueDate': instance.dueDate?.toIso8601String(),
  'projectId': instance.projectId,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$TaskPriorityEnumMap = {
  TaskPriority.basse: 'basse',
  TaskPriority.moyenne: 'moyenne',
  TaskPriority.haute: 'haute',
  TaskPriority.urgente: 'urgente',
};

const _$TaskStatusEnumMap = {
  TaskStatus.afaire: 'afaire',
  TaskStatus.enCours: 'enCours',
  TaskStatus.terminee: 'terminee',
};
