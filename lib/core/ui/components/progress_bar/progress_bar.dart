import 'package:flutter/cupertino.dart';
import 'package:prtmobile/core/core.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
    required this.progress,
    required this.height,
    this.width,
  }) : super(key: key);

  final double progress;
  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: width ?? constraints.maxWidth,
          height: height,
          child: CustomPaint(
            painter: ProgressBarPainter(
              progress: progress,
            ),
          ),
        );
      },
    );
  }
}

class ProgressBarPainter extends CustomPainter {
  final double progress;

  ProgressBarPainter({
    required this.progress,
  });

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = Radius.circular(size.height / 2);

    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, radius);
    canvas.clipRRect(rrect);

    final leftPaint = Paint()..color = AppColors.grey;
    canvas.drawRRect(rrect, leftPaint);

    final donePaint = Paint()..color = const Color(0xFF228B22);

    final doneWidth = progress * size.width;
    final doneRect = Offset.zero & Size(doneWidth, size.height);

    canvas.drawRect(doneRect, donePaint);
  }
}
