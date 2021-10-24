import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/typography.dart';

import '../storybook.dart';

class EditableTextExample extends StatefulWidget {
  const EditableTextExample({
    Key? key,
  }) : super(key: key);

  @override
  _EditableTextExampleState createState() => _EditableTextExampleState();
}

class _EditableTextExampleState extends State<EditableTextExample> {
  var inputSize = const Size(0.0, 0.0);
  var textSize = const Size(0.0, 0.0);

  var isInputEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 100,
        left: 50,
        right: 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TouchableOpacity(
            child: const Text('Toggle input'),
            onPressed: () {
              setState(() {
                isInputEnabled = !isInputEnabled;
              });
            },
          ),
          const SizedBox(height: 15),
          IntrinsicSize(
            onChange: (size) {
              setState(() {
                textSize = size;
              });
            },
            child: Text(
              'Example text',
              style: AppTypography.h2,
            ),
          ),
          IntrinsicSize(
            onChange: (size) {
              setState(() {
                inputSize = size;
              });
            },
            child: AppEditableText(
              style: AppTypography.h2,
              isEnabled: isInputEnabled,
            ),
          ),
          const SizedBox(height: 15),
          Text('Input height - ${inputSize.height}'),
          Text('Text height - ${textSize.height}'),
        ],
      ),
    );
  }
}

class EditableTextStories implements StorybookStory {
  @override
  String title = 'EditableText';

  @override
  List<StorybookStoryDefinition> getVariations() {
    return [
      StorybookStoryDefinition(
        type: 'default',
        contentBuilder: (context) {
          return const EditableTextExample();
        },
      ),
    ];
  }
}
