import 'package:frontend/utils/habit_type.dart';

class Habit {
  final String title;
  final String? description;
  final int color;
  final HabitType habitType;
  final DateTime? endDate;
  final DateTime createdAt = DateTime.now();

  Habit(this.title, this.description, this.color, this.habitType, this.endDate);
}
