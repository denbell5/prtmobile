import 'package:flutter/cupertino.dart';
import 'package:prtmobile/features/store/store.dart';
import 'package:prtmobile/core/core.dart';

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
      height: kSubtrackViewHeaderHeight,
      primaryTextSize: FontSizes.h4 - 1,
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
      trailing: Text('total ${subtrack.length}'),
      onTap: () {},
    );
  }
}