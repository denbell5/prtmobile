import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class BoxDetails extends Equatable {
  final Offset position;
  final Size size;

  const BoxDetails({
    required this.position,
    required this.size,
  });

  @override
  List<Object?> get props => [position, size];
}

BoxDetails getBoxOf(BuildContext context) {
  final box = context.findRenderObject() as RenderBox;
  final position = box.localToGlobal(Offset.zero);
  final size = box.size;
  return BoxDetails(position: position, size: size);
}
