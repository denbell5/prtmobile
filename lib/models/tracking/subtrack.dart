import 'package:prtmobile/models/models.dart';

class SubtrackRange extends Range {
  final int pointer;

  const SubtrackRange({
    required int start,
    required int end,
    required this.pointer,
  }) : super(start, end);

  @override
  List<Object?> get props => [...super.props, pointer];

  bool get isOnStart => pointer == start;
  bool get isOnEnd => pointer == end;

  int get length => end - start + 1;
  int get done {
    if (isOnStart) return 0;
    if (isOnEnd) return length;
    return pointer - start;
  }

  int get left {
    if (isOnStart) return length;
    if (isOnEnd) return 0;
    return end - pointer + 1;
  }
}

class Subtrack extends SubtrackRange {
  final String id;
  final String trackId;

  const Subtrack({
    required this.id,
    required this.trackId,
    required int start,
    required int end,
    required int pointer,
  }) : super(
          start: start,
          end: end,
          pointer: pointer,
        );

  @override
  List<Object?> get props => [...super.props, id, trackId];

  SubtrackRange get baseRange => SubtrackRange(
        start: start,
        end: end,
        pointer: pointer,
      );
}
