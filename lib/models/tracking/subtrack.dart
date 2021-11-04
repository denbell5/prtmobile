import 'package:equatable/equatable.dart';

class SubtrackRange extends Equatable {
  final int start;
  final int end;
  final int pointer;

  const SubtrackRange({
    required this.start,
    required this.end,
    required this.pointer,
  });

  @override
  List<Object?> get props => [start, end, pointer];

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

  const Subtrack({
    required this.id,
    required int start,
    required int end,
    required int pointer,
  }) : super(
          start: start,
          end: end,
          pointer: pointer,
        );

  @override
  List<Object?> get props => [...super.props, id];

  SubtrackRange get baseRange => SubtrackRange(
        start: start,
        end: end,
        pointer: pointer,
      );
}
