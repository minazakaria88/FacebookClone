import 'package:flutter/widgets.dart';

extension WidthAndHeight on int {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
}
