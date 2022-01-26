// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/styles.dart';

import '../storybook.dart';

class InputExample extends StatefulWidget {
  const InputExample({
    Key? key,
  }) : super(key: key);

  @override
  _InputExampleState createState() => _InputExampleState();
}

class _InputExampleState extends State<InputExample> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(50).copyWith(top: 100),
        child: Form(
          key: _formKey,
          onChanged: () {
            _formKey.currentState!.validate();
            _formKey.currentState!.save();
          },
          child: Input(
            label: 'Name',
            initialValue: 'Initial text',
            onSaved: (value) {
              print('Saved value $value ${DateTime.now()}');
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please provide a name';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}

class InputStories implements StorybookStory {
  @override
  String title = 'Input';

  @override
  List<StorybookStoryDefinition> getVariations() {
    const defaultTextTheme = CupertinoTextThemeData();
    return [
      StorybookStoryDefinition(
        type: 'default',
        contentBuilder: (context) {
          return CupertinoApp(
            home: const InputExample(),
            theme: AppThemeData(
              scaffoldBackgroundColor: AppColors.white,
              primaryColor: AppColors.mineShaft,
              barBackgroundColor: AppColors.mineShaft,
              primaryContrastingColor: AppColors.white,
              textTheme: defaultTextTheme.copyWith(
                textStyle: defaultTextTheme.textStyle.merge(
                  AppTypography.bodyText,
                ),
              ),
            ),
          );
        },
      ),
    ];
  }
}
