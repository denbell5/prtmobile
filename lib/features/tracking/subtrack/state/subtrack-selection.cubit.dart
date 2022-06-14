import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedSubtrackInfo extends Equatable {
  final String? id;

  const SelectedSubtrackInfo({
    required this.id,
  });

  SelectedSubtrackInfo change(String? next) {
    return SelectedSubtrackInfo(
      id: next,
    );
  }

  @override
  List<Object?> get props => [id];
}

class SelectedSubtrackCubit extends Cubit<SelectedSubtrackInfo> {
  SelectedSubtrackCubit()
      : super(
          const SelectedSubtrackInfo(
            id: null,
          ),
        );

  void emitChange(String? selectedId) {
    emit(state.change(selectedId));
  }
}
