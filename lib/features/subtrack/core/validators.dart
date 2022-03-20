import 'package:prtmobile/core/core.dart';
import 'package:collection/collection.dart';

String? validateRange(Range range) {
  if (range.start > range.end) {
    return 'Start is greater than End';
  }
  return null;
}

String? validatePointer(SubtrackRange range) {
  if (range.start > range.pointer || range.end < range.pointer) {
    return 'Pointer is outside of the range';
  }
  return null;
}

String? validateIntersection({
  required Range range,
  required List<Subtrack> subtracks,
}) {
  final intersectingSubtrack = subtracks.firstWhereOrNull(
    (sb) => hasIntersection(sb, range),
  );
  if (intersectingSubtrack != null) {
    return 'Intersects with existing subtrack ${intersectingSubtrack.start} - ${intersectingSubtrack.end}';
  }
  return null;
}
