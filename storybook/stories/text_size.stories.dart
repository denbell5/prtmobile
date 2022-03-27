import 'package:flutter/material.dart';
import 'package:prtmobile/core/core.dart';
import '../storybook.dart';

class TextSizeExample extends StatefulWidget {
  const TextSizeExample({
    Key? key,
  }) : super(key: key);

  @override
  _TextSizeExampleState createState() => _TextSizeExampleState();
}

class _TextSizeExampleState extends State<TextSizeExample> {
  var actualTextHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    const fontSize = 16.0;
    const fontHeight = 1.4;
    const textStyle = TextStyle(
      fontSize: fontSize,
      height: fontHeight,
      // weight doesn't affect the height
      fontWeight: FontWeight.bold,
    );
    final textScale = mediaQuery.textScaleFactor;
    final rawCalculatedHeight = fontSize * fontHeight * textScale;
    final calculatedHeight = calcTextSize(
      fontSize: fontSize,
      fontHeight: fontHeight,
      scaleFactor: textScale,
    );
    return Padding(
      padding: const EdgeInsets.only(
        top: 100,
        left: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: IntrinsicSize(
              onChange: (size) {
                setState(() {
                  actualTextHeight = size.height;
                });
              },
              child: const Text(
                'Example text',
                style: textStyle,
              ),
            ),
          ),
          const Height(7.5),
          Text('Actual height - $actualTextHeight'),
          Text('Raw calculated height - $rawCalculatedHeight'),
          Text('Rounded calculated height - $calculatedHeight'),
          const Height(7.5),
          const Text('Font size - $fontSize'),
          Text('Text scale factor - $textScale'),
          const Text('Text height factor - $fontHeight'),
        ],
      ),
    );
  }
}

class TextSizeStories implements StorybookStory {
  @override
  String title = 'Text Size';

  @override
  List<StorybookStoryDefinition> getVariations() {
    return [
      StorybookStoryDefinition(
        type: 'default',
        contentBuilder: (context) {
          return const TextSizeExample();
        },
      ),
    ];
  }
}
