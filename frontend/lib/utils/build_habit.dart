import 'package:frontend/utils/goal_period.dart';
import 'package:frontend/utils/goal_value.dart';
import 'package:frontend/utils/habit_type.dart';

class BuildHabit extends HabitType {
  GoalPeriod goalPeriod;
  GoalValue goalValue;

  BuildHabit(this.goalPeriod, this.goalValue);
}
