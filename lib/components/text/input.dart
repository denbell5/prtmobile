import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/styles.dart';

class Input extends FormField<String> {
  final bool isEnabled;
  final TextStyle? style;
  final String initialText;
  final double borderWidth;
  final void Function(String? text)? onErrorTextChanged;

  Input({
    Key? key,
    this.style,
    this.isEnabled = true,
    this.initialText = '',
    this.onErrorTextChanged,
    this.borderWidth = kInputBorderWidth,
    Color? cursorColor,
    Color? borderColor,
    Color? borderFocusedColor,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialText,
          builder: (field) {
            final state = field as _AppEditableTextState;
            cursorColor = cursorColor ?? AppColors.grey;
            borderColor = borderColor ?? AppColors.lightGrey;
            borderFocusedColor = borderFocusedColor ?? AppColors.grey;
            final activeBorderColor = isEnabled
                ? AppColors.transparent
                : state._isFocused
                    ? borderFocusedColor
                    : borderColor;
            return Column(
              children: [
                CupertinoTextField(
                  expands: false,
                  decoration: null,
                  style: style,
                  enabled: isEnabled,
                  cursorColor: cursorColor,
                  focusNode: state._focusNode,
                  controller: state._controller,
                  onChanged: (value) {
                    state.didChange(value);
                  },
                ),
                HorizontalDivider(
                  height: borderWidth,
                  color: activeBorderColor,
                )
              ],
            );
          },
        );

  @override
  _AppEditableTextState createState() => _AppEditableTextState();
}

class _AppEditableTextState extends FormFieldState<String> {
  late FocusNode _focusNode;
  late TextEditingController _controller;
  var _isFocused = false;
  String? _lastErrorText;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  bool validate() {
    final result = super.validate();
    if (_lastErrorText != errorText) {
      (widget as Input).onErrorTextChanged?.call(errorText);
    }
    _lastErrorText = errorText;
    return result;
  }
}
