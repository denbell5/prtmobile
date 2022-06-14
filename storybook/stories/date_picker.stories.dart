// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/widgets.dart';
import 'package:prtmobile/core/core.dart';

import '../storybook.dart';

class DatePickerExample extends StatefulWidget {
  const DatePickerExample({
    Key? key,
  }) : super(key: key);

  @override
  _DatePickerExampleState createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 100,
      ),
      child: Center(
        child: DatePicker(
          label: 'Starts',
          dateValue: DateTime.now(),
          onChanged: (date) {
            print('Date value changed $date');
          },
        ),
      ),
    );
  }
}

class DatePickerStories implements StorybookStory {
  @override
  String title = 'DatePicker';

  @override
  List<StorybookStoryDefinition> getVariations() {
    return [
      StorybookStoryDefinition(
        type: 'default',
        contentBuilder: (context) {
          return const DatePickerExample();
        },
      ),
    ];
  }
}
