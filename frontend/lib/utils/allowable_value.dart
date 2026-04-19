import 'package:frontend/utils/unit.dart';
import 'package:frontend/utils/value.dart';

class AllowableValue extends Value {
  final int count;
  final Unit unit;

  AllowableValue({required this.count, required this.unit});
}
