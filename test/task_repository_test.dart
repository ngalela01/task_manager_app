import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager_app/domain/entities/task.dart';

import 'mocks/repository_mocks.mocks.dart';

void main() {
  test('charge les taches depuis un repository mocke', () async {
    final repository = MockTaskRepository();
    final tasks = [
      Task(
        id: '1',
        title: 'Tache test',
        createdAt: DateTime(2026, 6, 5),
      ),
    ];

    when(repository.getTasks()).thenAnswer((_) async => tasks);

    final result = await repository.getTasks();

    expect(result.length, 1);
    expect(result.first.title, 'Tache test');
  });
}
