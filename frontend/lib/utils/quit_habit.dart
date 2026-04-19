import 'package:frontend/utils/allowable_value.dart';
import 'package:frontend/utils/goal_period.dart';
import 'package:frontend/utils/habit_type.dart';

class QuitHabit extends HabitType {
  GoalPeriod goalPeriod;
  AllowableValue allowableValue;

  QuitHabit(this.goalPeriod, this.allowableValue);
}
