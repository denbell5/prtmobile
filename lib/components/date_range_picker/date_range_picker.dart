import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/styles/layout.dart';

class DateRangePicker extends StatefulWidget {
  const DateRangePicker({
    Key? key,
    required this.initialValue,
    required this.onSaved,
  }) : super(key: key);

  final DateRange initialValue;
  final ValueChanged<DateRange?>? onSaved;

  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  @override
  Widget build(BuildContext context) {
    return FormField<DateRange>(
      initialValue: widget.initialValue,
      onSaved: widget.onSaved,
      validator: (value) {
        final start = value!.start;
        final end = value.end;
        if (!start.isBefore(end)) {
          return 'Please select start to be before end';
        }
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
                state.didChange(
                  currentValue.copyWith(start: start),
                );
              },
              errorSpacePreserved: false,
            ),
            const SizedBox(height: kDefaultPadding / 2),
            DatePicker(
              label: 'Ends',
              dateValue: currentValue.end,
              errorText: state.errorText,
              onChanged: (end) {
                state.didChange(
                  currentValue.copyWith(end: end),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
