import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/components/text/list_item_header.dart';
import 'package:prtmobile/features/subtrack/subtrack.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/styles/styles.dart';

const kSubtrackViewHeaderHeight = 60.0;

class SubtrackView extends StatefulWidget {
  const SubtrackView({
    Key? key,
    required this.subtrack,
    required this.toggleItemSelection,
    required this.onEnableSelectionMode,
    required this.isSelected,
    required this.selectionModeEnabled,
  }) : super(key: key);

  final Subtrack subtrack;
  final void Function(String subtrackId) toggleItemSelection;
  final void Function(String subtrackId) onEnableSelectionMode;
  final bool isSelected;
  final bool selectionModeEnabled;

  @override
  State<SubtrackView> createState() => _SubtrackViewState();
}

class _SubtrackViewState extends State<SubtrackView>
    with SingleTickerProviderStateMixin {
  Subtrack get subtrack => widget.subtrack;

  void onSelected() {
    if (widget.selectionModeEnabled) {
      widget.toggleItemSelection(subtrack.id);
    } else {
      final cubit = BlocProvider.of<SelectedSubtrackCubit>(context);
      cubit.emitChange(subtrack.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListItemHeader(
      height: kSubtrackViewHeaderHeight,
      primaryTextSize: FontSizes.h4 - 1,
      primaryText:
          '${subtrack.start} - ${subtrack.end}, stopped on ${subtrack.pointer}',
      trailing: Text('completed ${subtrack.done}/${subtrack.length}'),
      onTap: onSelected,
      bgColor: widget.isSelected ? AppColors.lightGrey : null,
      onLongPress: () => widget.onEnableSelectionMode(subtrack.id),
      primary: RichText(
        text: TextSpan(
          style: CupertinoTheme.of(context).textTheme.textStyle,
          children: <TextSpan>[
            TextSpan(
              text: '${subtrack.start} - ${subtrack.end}, ',
              style: StatStyles.kAccentTextStyle,
            ),
            TextSpan(
              text: 'stopped on',
              style: StatStyles.kSecondaryTextStyle,
            ),
            TextSpan(
              text: ' ${subtrack.pointer}',
              style: StatStyles.kAccentTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
