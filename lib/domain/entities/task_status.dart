import 'package:flutter/material.dart';

enum TaskStatus {
  afaire,
  enCours,
  terminee;

  String get label {
    switch (this) {
      case TaskStatus.afaire:
        return 'A faire';
      case TaskStatus.enCours:
        return 'En cours';
      case TaskStatus.terminee:
        return 'Terminee';
    }
  }

  Color get textColor {
    switch (this) {
      case TaskStatus.afaire:
        return Colors.blue;
      case TaskStatus.enCours:
        return Colors.orange;
      case TaskStatus.terminee:
        return Colors.green;
    }
  }
}
