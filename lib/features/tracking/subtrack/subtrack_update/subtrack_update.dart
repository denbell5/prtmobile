import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/features/tracking/tracking.dart';
import 'package:prtmobile/core/core.dart';

enum RangeField { start, end, pointer }

const _fieldOptions = [
  SelectableOption('Start', RangeField.start),
  SelectableOption('End', RangeField.end),
  SelectableOption('Pointer', RangeField.pointer),
];

class SubtrackFormValues extends Equatable {
  final int start;
  final int end;
  final int pointer;

  const SubtrackFormValues({
    required this.start,
    required this.end,
    required this.pointer,
  });

  SubtrackFormValues.fromSubtrack(SubtrackRange subtrack)
      : start = subtrack.start,
        end = subtrack.end,
        pointer = subtrack.pointer;

  SubtrackRange toSubtrackRange() {
    return SubtrackRange(start: start, end: end, pointer: pointer);
  }

  SubtrackFormValues copyWith({
    int? start,
    int? end,
    int? pointer,
  }) {
    return SubtrackFormValues(
      start: start ?? this.start,
      end: end ?? this.end,
      pointer: pointer ?? this.pointer,
    );
  }

  SubtrackFormValues updateField(RangeField el, int value) {
    if (el == RangeField.start) {
      return copyWith(start: value);
    }
    if (el == RangeField.end) {
      return copyWith(end: value);
    }
    if (el == RangeField.pointer) {
      return copyWith(pointer: value);
    }
    throw UnimplementedError();
  }

  int getFieldValue(RangeField el) {
    if (el == RangeField.start) {
      return start;
    }
    if (el == RangeField.end) {
      return end;
    }
    if (el == RangeField.pointer) {
      return pointer;
    }
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [start, end, pointer];
}

class SubtrackUpdateDialog extends StatefulWidget {
  const SubtrackUpdateDialog({
    Key? key,
    required this.subtrack,
    required this.track,
  }) : super(key: key);

  final Subtrack subtrack;
  final Track track;

  @override
  _SubtrackUpdateDialogState createState() => _SubtrackUpdateDialogState();
}

class _SubtrackUpdateDialogState extends State<SubtrackUpdateDialog> {
  final debouncer = Debouncer(ms: 400);

  late SubtrackFormValues _formValues;
  SubtrackFormValues get lastSavedFormValues {
    return SubtrackFormValues.fromSubtrack(
      widget.subtrack,
    );
  }

  String _errorText = '';
  RangeField _selectedField = RangeField.pointer;

  @override
  void initState() {
    super.initState();
    _formValues = SubtrackFormValues.fromSubtrack(
      widget.subtrack,
    );
  }

  @override
  void didUpdateWidget(SubtrackUpdateDialog oldWidget) {
    if (widget.subtrack != oldWidget.subtrack) {
      _formValues = lastSavedFormValues;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _handleValueSelected(int value) {
    _formValues = _formValues.updateField(_selectedField, value);

    final otherSubtracks = widget.track.subtracks.entities
        .where((x) => x.id != widget.subtrack.id)
        .toList();
    final range = SubtrackRange(
      start: _formValues.start,
      end: _formValues.end,
      pointer: _formValues.pointer,
    );
    final errorText = combineValidators([
      () => validateRange(range),
      () => validatePointer(range),
      () => validateIntersection(range: range, subtracks: otherSubtracks),
    ]);

    _errorText = errorText ?? '';
    setState(() {});

    if (errorText == null) {
      TrackingBloc.of(context).add(
        SubtrackEdited(
          value: _formValues,
          subtrackId: widget.subtrack.id,
          trackId: widget.track.id,
          tracksetId: widget.track.tracksetId,
        ),
      );
    }
  }

  void _handleRangeElementSelected(RangeField value) {
    setState(() {
      _selectedField = value;
    });
  }

  Widget buildHeader() {
    final text =
        '${_formValues.start} - ${_formValues.end}, ${_formValues.pointer}';
    return Text(
      text,
      style: FormStyles.kHeaderTextStyle,
    );
  }

  Widget buildError() {
    return Text(
      _errorText,
      style: AppTypography.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemTextStyle = AppTypography.h2.copyWith(height: 1);
    final itemFontSize = itemTextStyle.fontSize!;
    final itemTextHeight = calcTextSize(
      fontSize: itemFontSize,
      fontHeight: 1,
      scaleFactor: MediaQuery.of(context).textScaleFactor,
    );
    const itemPadding = kDefaultPadding / 2;
    final itemExtent = itemTextHeight + itemPadding * 2;
    final pickerHeight = itemExtent * 2.5;
    return BottomDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 50,
            child: Stack(
              children: [
                Positioned.fill(
                  left: TouchableIcon.defaultPadding.left,
                  right: null,
                  child: Align(
                    child: BlocBuilder<TrackingBloc, TrackingState>(
                      builder: (context, state) {
                        var status = '';
                        if (_errorText.isNotEmpty) {
                          status = '';
                        } else if (state is TrackingLoadingState &&
                            state.isEditingSubtrack) {
                          status = 'Saving...';
                        } else if (state is TrackingUpdatedState &&
                            state.isAfterSubtrackEdited) {
                          status = 'Saved';
                        } else if (state is TrackingErrorState &&
                            state.isSubtrackEditFailed) {
                          status = 'Error';
                        }
                        return Text(status);
                      },
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    child: buildHeader(),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: TouchableIcon(
                    adjustToHeight: 50,
                    iconData: CupertinoIcons.xmark,
                    onTap: () {
                      AppNavigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          Row(
            children: [
              Expanded(
                child: SelectableColumn<RangeField>(
                  onSelected: _handleRangeElementSelected,
                  initialSelected: _selectedField,
                  options: _fieldOptions,
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: pickerHeight,
                  child: PickerList(
                    onSelected: (value) {
                      debouncer.run(() {
                        _handleValueSelected(value);
                      });
                    },
                    itemBuilder: (ctx, index) {
                      if (index <= 0) {
                        return null;
                      }
                      return Center(
                        child: Text(
                          index.toString(),
                          style: itemTextStyle,
                        ),
                      );
                    },
                    itemExtent: itemExtent,
                    initialIndex: _formValues.getFieldValue(
                      _selectedField,
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          const Height(kDefaultPadding),
          buildError(),
          const Height(kDefaultPadding),
        ],
      ),
    );
  }
}
