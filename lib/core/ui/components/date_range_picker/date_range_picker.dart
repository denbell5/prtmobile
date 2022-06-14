import 'package:flutter/cupertino.dart';
import 'package:prtmobile/core/core.dart';

class DateRangePicker extends StatefulWidget {
  const DateRangePicker({
    Key? key,
    this.formFieldKey,
    required this.initialValue,
    required this.onSaved,
    this.onChanged,
  }) : super(key: key);

  final DateRange initialValue;
  final ValueChanged<DateRange?>? onSaved;
  final ValueChanged<DateRange>? onChanged;
  final Key? formFieldKey;

  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  @override
  Widget build(BuildContext context) {
    return FormField<DateRange>(
      key: widget.formFieldKey,
      initialValue: widget.initialValue,
      onSaved: widget.onSaved,
      validator: (value) {
        final start = value!.start;
        final end = value.end;
        if (!start.isBefore(end)) {
          return 'Please select start to be before end';
        }
        return null;
      },
      builder: (state) {
        final currentValue = state.value!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DatePicker(
              label: 'Starts',
              dateValue: currentValue.start,
              onChanged: (start) {
                final newValue = currentValue.copyWith(start: start);
                state.didChange(newValue);
                widget.onChanged?.call(newValue);
              },
              errorSpacePreserved: false,
            ),
            const Height(kDefaultPadding / 2),
            DatePicker(
              label: 'Ends',
              dateValue: currentValue.end,
              errorText: state.errorText,
              onChanged: (end) {
                final newValue = currentValue.copyWith(end: end);
                state.didChange(newValue);
                widget.onChanged?.call(newValue);
              },
            ),
          ],
        );
      },
    );
  }
}
