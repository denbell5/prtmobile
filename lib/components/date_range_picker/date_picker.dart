import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/text/highlighted.dart';
import 'package:prtmobile/styles/styles.dart';
import 'package:prtmobile/utils/date.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    Key? key,
    required this.dateValue,
    required this.onChanged,
    required this.label,
    this.errorText,
    this.errorSpacePreserved = true,
  }) : super(key: key);

  final DateTime dateValue;
  final ValueChanged<DateTime> onChanged;
  final String? errorText;
  final String label;
  final bool errorSpacePreserved;

  @override
  Widget build(BuildContext context) {
    const leftInset = kInputBorderRadius;
    final bgColor = CupertinoTheme.of(context).scaffoldBackgroundColor;
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return FractionallySizedBox(
              heightFactor: 0.3,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: dateValue,
                backgroundColor: bgColor,
                onDateTimeChanged: onChanged,
              ),
            );
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: leftInset),
            child: Text(
              label,
              style: AppTypography.bodyText.greyed(),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Highlighted(
                  horizontalInset: leftInset,
                  child: Text(
                    formatDate(dateValue),
                  ),
                ),
              ),
            ],
          ),
          if (errorSpacePreserved || errorText != null)
            Padding(
              padding: const EdgeInsets.only(left: leftInset),
              child: Text(
                errorText ?? '',
                style: AppTypography.small.red(),
              ),
            )
        ],
      ),
    );
  }
}
