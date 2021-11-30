import 'stories/bottom_dialog.stories.dart';
import 'stories/editable_text.stories.dart';
import 'stories/expandable.stories.dart';
import 'stories/expandable_list_poc.stories.dart';
import 'stories/picker_list.stories.dart';
import 'stories/subtrack_update.stories.dart';
import 'stories/text_size.stories.dart';
import 'stories/theme.stories.dart';
import 'stories/touchable_color.stories.dart';
import 'stories/touchable_opacity.stories.dart';
import 'storybook.dart';

final stories = <StorybookStory>[
  BottomDialogStories(),
  SubtrackUpdateStories(),
  ListPickerStories(),
  EditableTextStories(),
  TextSizeStories(),
  TouchableColorStories(),
  TouchableOpacityStories(),
  ThemeStories(),
  ExpandableStories(),
  ExpandableListPocStories(),
];
