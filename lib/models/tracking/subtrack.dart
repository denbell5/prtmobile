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

  SubtrackRange get range => SubtrackRange(
        start: start,
        end: end,
        pointer: pointer,
      );
}
