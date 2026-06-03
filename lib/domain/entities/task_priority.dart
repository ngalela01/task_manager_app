enum TaskPriority {
  basse,
  moyenne,
  haute,
  urgente;

  String get label {
    switch (this) {
      case TaskPriority.basse:
        return '\u2193 Basse';
      case TaskPriority.moyenne:
        return '- Moyenne';
      case TaskPriority.haute:
        return '\u2191 Haute';
      case TaskPriority.urgente:
        return '! Urgente';
    }
  }
}
