import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prtmobile/styles/styles.dart';

import '../storybook.dart';

class ThemeExample extends StatefulWidget {
  const ThemeExample({
    Key? key,
    required this.themeData,
  }) : super(key: key);

  final ThemeData themeData;

  @override
  _ThemeExampleState createState() => _ThemeExampleState();
}

class _ThemeExampleState extends State<ThemeExample> {
  Widget get divider => const SizedBox(height: 5);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: widget.themeData,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 100,
          left: 50,
        ),
        child: Builder(
          builder: (context) {
            final theme = Theme.of(context);
            return SingleChildScrollView(
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Example text - without style',
                      style: TextStyle(fontSize: 16),
                    ),
                    divider,
                    Text(
                      'Example text - bodyText2',
                      style: theme.textTheme.bodyText2!.copyWith(fontSize: 16),
                    ),
                    divider,
                    Text(
                      'Example text - bodyText1',
                      style: theme.textTheme.bodyText1,
                    ),
                    divider,
                    Text(
                      'Example text - button',
                      style: theme.textTheme.button,
                    ),
                    divider,
                    Text(
                      'Example text - caption',
                      style: theme.textTheme.caption,
                    ),
                    divider,
                    Text(
                      'Example text - headline6',
                      style: theme.textTheme.headline6,
                    ),
                    divider,
                    Text(
                      'Example text - headline5',
                      style: theme.textTheme.headline5,
                    ),
                    divider,
                    Text(
                      'Example text - headline4',
                      style: theme.textTheme.headline4,
                    ),
                    divider,
                    Text(
                      'Example text - headline3',
                      style: theme.textTheme.headline3,
                    ),
                    divider,
                    Text(
                      'Example text - headline2',
                      style: theme.textTheme.headline2,
                    ),
                    divider,
                    Text(
                      'Example text - headline1',
                      style: theme.textTheme.headline1,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomThemeExample extends StatefulWidget {
  const CustomThemeExample({
    Key? key,
  }) : super(key: key);

  @override
  _CustomThemeExampleState createState() => _CustomThemeExampleState();
}

class _CustomThemeExampleState extends State<CustomThemeExample> {
  Widget get divider => const SizedBox(height: 5);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 100,
          left: 15,
        ),
        child: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Example text - without style',
                    ),
                    divider,
                    Text(
                      'Example text - bodyText',
                      style: AppTypography.bodyText,
                    ),
                    divider,
                    Text(
                      'Example text - h3',
                      style: AppTypography.h3,
                    ),
                    divider,
                    Text(
                      'Example text - h2',
                      style: AppTypography.h2,
                    ),
                    divider,
                    divider,
                    divider,
                    Text(
                      'Example text - bold',
                      style: AppTypography.bodyText.bold(),
                    ),
                    divider,
                    Text(
                      'Example text - greyed',
                      style: AppTypography.bodyText.greyed(),
                    ),
                    divider,
                    divider,
                    divider,
                    Text(
                      'Q1 - Q2 2021',
                      style: AppTypography.h3,
                    ),
                    Text(
                      '10/20/2021 - 10/20/2021',
                      style: AppTypography.bodyText,
                    ),
                    divider,
                    divider,
                    divider,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ThemeStories implements StorybookStory {
  @override
  String title = 'Theme';

  @override
  List<StorybookStoryDefinition> getVariations() {
    return [
      StorybookStoryDefinition(
        type: 'default',
        contentBuilder: (context) {
          return ThemeExample(
            themeData: ThemeData(),
          );
        },
      ),
      StorybookStoryDefinition(
        type: 'custom',
        contentBuilder: (context) {
          return const CustomThemeExample();
        },
      ),
    ];
  }
}
