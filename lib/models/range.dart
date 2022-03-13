import 'package:equatable/equatable.dart';

class Range extends Equatable {
  final int start;
  final int end;

  const Range(this.start, this.end);

  @override
  List<Object?> get props => [start, end];
}
