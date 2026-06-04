import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager_app/application/providers/repository_providers.dart';
import 'package:task_manager_app/application/providers/task_notifier.dart';
import 'package:task_manager_app/domain/entities/task.dart';

import 'mocks/repository_mocks.mocks.dart';

void main() {
  test('ajoute une tache avec le notifier', () async {
    final repository = MockTaskRepository();

    final task = Task(
      id: '1',
      title: 'Nouvelle tache',
      createdAt: DateTime(2026, 6, 5),
    );

    when(repository.getTasks()).thenAnswer((_) async => []);
    when(repository.addTask(task)).thenAnswer((_) async {});
    when(repository.getTasks()).thenAnswer((_) async => [task]);

    final container = ProviderContainer(
      overrides: [
        taskRepositoryProvider.overrideWithValue(repository),
      ],
    );

    addTearDown(container.dispose);

    await container.read(taskNotifierProvider.future);

    await container.read(taskNotifierProvider.notifier).addTask(task);

    final result = await container.read(taskNotifierProvider.future);

    expect(result.length, 1);
    expect(result.first.title, 'Nouvelle tache');
    verify(repository.addTask(task)).called(1);
  });
}