// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/widgets.dart';
import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/models/models.dart';

import '../storybook.dart';

class DateRangePickerExample extends StatefulWidget {
  const DateRangePickerExample({
    Key? key,
  }) : super(key: key);

  @override
  _DateRangePickerExampleState createState() => _DateRangePickerExampleState();
}

class _DateRangePickerExampleState extends State<DateRangePickerExample> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 100,
      ),
      child: Form(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.validate();
          _formKey.currentState!.save();
        },
        child: DateRangePicker(
          initialValue: DateRange(
            start: DateTime.now(),
            end: DateTime.now(),
          ),
          onSaved: (dateRange) {
            print('Saved dateRange ${dateRange!.start} ${dateRange.end}');
          },
        ),
      ),
    );
  }
}

class DateRangePickerStories implements StorybookStory {
  @override
  String title = 'DateRangePicker';

  @override
  List<StorybookStoryDefinition> getVariations() {
    return [
      StorybookStoryDefinition(
        type: 'default',
        contentBuilder: (context) {
          return const DateRangePickerExample();
        },
      ),
    ];
  }
}
