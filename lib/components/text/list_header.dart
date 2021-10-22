import 'package:flutter/widgets.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/styles.dart';

class ListHeader extends StatelessWidget {
  const ListHeader({
    Key? key,
    required this.text,
    required this.onAddTap,
  }) : super(key: key);

  final String text;
  final VoidCallback onAddTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: AppTypography.bodyText.bold(),
        ),
        InlineButton(text: 'Add', onTap: onAddTap),
      ],
    );
  }
}
