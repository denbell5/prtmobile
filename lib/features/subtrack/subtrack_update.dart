import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/styles/styles.dart';
import 'package:prtmobile/utils/utils.dart';

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

  String? validate() {
    if (pointer > end) {
      return 'Pointer is bigger than End';
    }
  }

  @override
  List<Object?> get props => [start, end, pointer];
}

class SubtrackUpdate extends StatefulWidget {
  const SubtrackUpdate({
    Key? key,
    required this.subtrack,
  }) : super(key: key);

  final Subtrack subtrack;

  @override
  _SubtrackUpdateState createState() => _SubtrackUpdateState();
}

class _SubtrackUpdateState extends State<SubtrackUpdate> {
  final debouncer = Debouncer(ms: 400);

  late SubtrackFormValues _formValues;
  SubtrackFormValues get lastSavedFormValues {
    return SubtrackFormValues.fromSubtrack(
      widget.subtrack,
    );
  }

  String _zeroLevelErrorText = '';
  RangeField _selectedField = RangeField.pointer;

  @override
  void initState() {
    super.initState();
    _formValues = SubtrackFormValues.fromSubtrack(
      widget.subtrack,
    );
  }

  @override
  void didUpdateWidget(SubtrackUpdate oldWidget) {
    if (widget.subtrack != oldWidget.subtrack) {
      _formValues = lastSavedFormValues;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _handleValueSelected(int value) {
    _formValues = _formValues.updateField(_selectedField, value);
    _zeroLevelErrorText = _formValues.validate() ?? '';
    setState(() {});
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
      style: AppTypography.h4.bold().greyed(),
    );
  }

  Widget buildError() {
    return Text(
      _zeroLevelErrorText,
      style: AppTypography.bodyText.red(),
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
    return Column(
      children: [
        const HorizontalDivider(height: 3.0),
        buildHeader(),
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
        const SizedBox(height: kDefaultPadding / 2),
        buildError(),
        const SizedBox(height: kDefaultPadding / 2),
      ],
    );
  }
}
