import 'stories/bottom_dialog.stories.dart';
import 'stories/date_picker.stories.dart';
import 'stories/date_range_picker.stories.dart';
import 'stories/db.stories.dart';
import 'stories/expandable.stories.dart';
import 'stories/expandable_list_poc.stories.dart';
import 'stories/expandable_list_sort.stories.dart';
import 'stories/input.stories.dart';
import 'stories/picker_list.stories.dart';
import 'stories/subtrack_update.stories.dart';
import 'stories/tap_details.stories.dart';
import 'stories/text_size.stories.dart';
import 'stories/theme.stories.dart';
import 'stories/touchable_color.stories.dart';
import 'stories/touchable_opacity.stories.dart';

import 'storybook.dart';

final stories = <StorybookStory>[
  TapDetailsStories(),
  TouchableOpacityStories(),
  ExpandableListSortingStories(),
  DateRangePickerStories(),
  DatePickerStories(),
  InputStories(),
  DbStories(),
  BottomDialogStories(),
  SubtrackUpdateStories(),
  ListPickerStories(),
  TextSizeStories(),
  TouchableColorStories(),
  ThemeStories(),
  ExpandableStories(),
  ExpandableListPocStories(),
];
