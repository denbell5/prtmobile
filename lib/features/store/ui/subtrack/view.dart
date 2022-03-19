import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/text/list_item_header.dart';
import 'package:prtmobile/features/store/store.dart';
import 'package:prtmobile/styles/styles.dart';

const kSubtrackViewHeaderHeight = 50.0;

class SubtrackSoView extends StatefulWidget {
  const SubtrackSoView({
    Key? key,
    required this.subtrack,
  }) : super(key: key);

  final SubtrackSo subtrack;

  @override
  State<SubtrackSoView> createState() => _SubtrackSoViewState();
}

class _SubtrackSoViewState extends State<SubtrackSoView>
    with SingleTickerProviderStateMixin {
  SubtrackSo get subtrack => widget.subtrack;

  @override
  Widget build(BuildContext context) {
    return ListItemHeader(
      axis: Axis.horizontal,
      height: kSubtrackViewHeaderHeight,
      primaryTextSize: FontSizes.h4 - 1,
      secondaryText: Text('total ${subtrack.length}'),
      primary: RichText(
        text: TextSpan(
          style: CupertinoTheme.of(context).textTheme.textStyle,
          children: <TextSpan>[
            TextSpan(
              text: '${subtrack.start} - ${subtrack.end}',
              style: StatStyles.kAccentTextStyle,
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
