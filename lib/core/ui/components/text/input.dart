// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:prtmobile/core/core.dart';

class Input extends StatefulWidget {
  const Input({
    Key? key,
    required this.label,
    this.initialValue,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  final String label;
  final String? initialValue;
  final ValueChanged<String?>? onSaved;
  final FormFieldValidator<String>? validator;

  @override
  InputState createState() => InputState();
}

class InputState extends State<Input> {
  late final TextEditingController _controller;
  final _formFieldKey = GlobalKey<FormFieldState<String>>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  void setValue(String value) {
    _controller.text = value;
    _formFieldKey.currentState!.didChange(value);
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = kComponentBorderRadius;
    const borderRadiusInsets = EdgeInsets.only(left: borderRadius);

    return FormField<String>(
      key: _formFieldKey,
      onSaved: widget.onSaved,
      validator: widget.validator,
      initialValue: widget.initialValue,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: borderRadiusInsets,
              child: Text(widget.label),
            ),
            CupertinoTextField(
              controller: _controller,
              onChanged: (value) {
                state.didChange(value);
              },
              expands: false,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.black),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              cursorColor: AppColors.black,
              cursorWidth: 0.7,
              padding: EdgeInsets.symmetric(
                horizontal: borderRadius,
                vertical: borderRadius,
              ),
            ),
            Padding(
              padding: borderRadiusInsets,
              child: Text(
                state.errorText ?? '',
                style: AppTypography.error,
              ),
            )
          ],
        );
      },
    );
  }
}
