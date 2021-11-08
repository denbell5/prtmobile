import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubtrackSelection extends Equatable {
  final String? prev;
  final String? next;

  const SubtrackSelection({
    required this.prev,
    required this.next,
  });

  SubtrackSelection change(String? next) {
    return SubtrackSelection(
      prev: this.next,
      next: next,
    );
  }

  @override
  List<Object?> get props => [next, prev];
}

class ActiveSubtrackCubit extends Cubit<SubtrackSelection> {
  ActiveSubtrackCubit()
      : super(
          const SubtrackSelection(
            prev: null,
            next: null,
          ),
        );

  void emitChange(String? next) {
    emit(state.change(next));
  }
}
