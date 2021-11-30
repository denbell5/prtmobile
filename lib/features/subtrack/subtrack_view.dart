import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/components/text/list_item_header.dart';
import 'package:prtmobile/features/subtrack/subtrack.dart';
import 'package:prtmobile/models/models.dart';

class SubtrackView extends StatefulWidget {
  const SubtrackView({
    Key? key,
    required this.subtrack,
  }) : super(key: key);

  final Subtrack subtrack;

  @override
  State<SubtrackView> createState() => _SubtrackViewState();
}

class _SubtrackViewState extends State<SubtrackView>
    with SingleTickerProviderStateMixin {
  Subtrack get subtrack => widget.subtrack;

  void onSelectionToggled() {
    final cubit = BlocProvider.of<ActiveSubtrackCubit>(context);
    if (cubit.state.next == subtrack.id) {
      cubit.emitChange(null);
    } else {
      cubit.emitChange(subtrack.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListItemHeader(
      axis: Axis.horizontal,
      primaryText:
          '${subtrack.start} - ${subtrack.end}, pointer ${subtrack.pointer}',
      secondaryText: 'completed ${subtrack.done}/${subtrack.length}',
      onTap: onSelectionToggled,
    );
  }
}
