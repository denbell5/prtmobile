import 'package:flutter/widgets.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/styles.dart';

class SelectableOption<T> {
  final String label;
  final T value;

  const SelectableOption(this.label, this.value);
}

class SelectableColumn<T> extends StatefulWidget {
  const SelectableColumn({
    Key? key,
    required this.options,
    required this.initialSelected,
    required this.onSelected,
  }) : super(key: key);

  final List<SelectableOption<T>> options;
  final T initialSelected;
  final ValueChanged<T> onSelected;

  @override
  _SelectableColumnState<T> createState() => _SelectableColumnState<T>();
}

class _SelectableColumnState<T> extends State<SelectableColumn<T>> {
  late T _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.options
        .firstWhere((el) => el.value == widget.initialSelected)
        .value;
  }

  Widget _buildOption(SelectableOption option) {
    final textStyle = option.value == _selectedValue
        ? AppTypography.bodyText.bold()
        : AppTypography.bodyText;
    return TouchableOpacity(
      child: Padding(
        padding: const EdgeInsets.all(kHorizontalPadding / 2),
        child: Text(
          option.label,
          style: textStyle,
        ),
      ),
      onPressed: () {
        setState(() {
          _selectedValue = option.value;
        });
        widget.onSelected(option.value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.map((el) => _buildOption(el)).toList(),
    );
  }
}
