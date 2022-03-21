import 'package:prtmobile/core/core.dart';

bool hasIntersection(Range r1, Range r2) {
  return r1.start <= r2.end && r2.start <= r1.end;
}
