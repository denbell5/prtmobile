import 'stories/editable_text.stories.dart';
import 'stories/expandable.stories.dart';
import 'stories/expandable_list_poc.stories.dart';
import 'stories/text_size.stories.dart';
import 'stories/theme.stories.dart';
import 'stories/touchable_color.stories.dart';
import 'stories/touchable_opacity.stories.dart';
import 'storybook.dart';

final stories = <StorybookStory>[
  EditableTextStories(),
  TextSizeStories(),
  TouchableColorStories(),
  TouchableOpacityStories(),
  ThemeStories(),
  ExpandableStories(),
  ExpandableListPocStories(),
];
