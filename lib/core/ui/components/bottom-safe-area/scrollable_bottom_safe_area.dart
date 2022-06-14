import 'package:flutter/cupertino.dart';
import 'package:prtmobile/core/ui/ui.dart';

typedef ScrollableBottomSafeAreaChildBuilder = Widget Function(
  BuildContext context,
  BoxConstraints originalConstraints,
  double bottomInset,
);

class ScrollableBottomSafeArea extends StatelessWidget {
  const ScrollableBottomSafeArea({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final ScrollableBottomSafeAreaChildBuilder builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, originalConstraints) {
        return BottomSafeArea(
          builder: (context, bottomInset) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: originalConstraints,
                child: builder(
                  context,
                  originalConstraints,
                  bottomInset,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
