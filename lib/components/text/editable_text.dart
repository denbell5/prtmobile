import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/styles.dart';

class AppEditableText extends FormField<String> {
  final TextStyle? style;
  final double decorationHeight;
  final bool isEnabled;
  final String initialText;
  final void Function(String? text)? onErrorTextChanged;

  AppEditableText({
    Key? key,
    this.style,
    Color? decorationColor,
    Color? focusedDecorationColor,
    this.decorationHeight = kInputDecorationHeight,
    Color? cursorColor,
    this.isEnabled = true,
    this.initialText = '',
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    this.onErrorTextChanged,
  }) : super(
            key: key,
            initialValue: initialText,
            validator: validator,
            onSaved: onSaved,
            builder: (field) {
              decorationColor = decorationColor ?? AppColors.lightGrey;
              focusedDecorationColor = focusedDecorationColor ?? AppColors.grey;
              cursorColor = cursorColor ?? AppColors.grey;
              final state = field as _AppEditableTextState;
              return Column(
                children: [
                  TextField(
                    expands: false,
                    decoration: null,
                    cursorColor: cursorColor,
                    focusNode: state.focusNode,
                    style: style,
                    enabled: isEnabled,
                    controller: state.controller,
                    onChanged: (value) {
                      state.didChange(value);
                    },
                  ),
                  if (isEnabled)
                    HorizontalDivider(
                      height: decorationHeight,
                      color: state.isFocused
                          ? focusedDecorationColor
                          : decorationColor,
                    )
                  else
                    SizedBox(height: decorationHeight),
                ],
              );
            });

  @override
  _AppEditableTextState createState() => _AppEditableTextState();
}

class _AppEditableTextState extends FormFieldState<String> {
  var isFocused = false;
  late FocusNode focusNode;
  late TextEditingController controller;
  String? lastErrorText;
  int buildCounter = 0;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  bool validate() {
    final result = super.validate();
    if (lastErrorText != errorText) {
      (widget as AppEditableText).onErrorTextChanged?.call(errorText);
    }
    lastErrorText = errorText;
    return result;
  }
}
