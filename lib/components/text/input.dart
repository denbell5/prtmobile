// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:prtmobile/styles/styles.dart';

class Input extends StatefulWidget {
  const Input({
    Key? key,
    required this.label,
    this.errorMessage = '',
    this.initialValue,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  final String label;
  final String errorMessage;
  final String? initialValue;
  final ValueChanged<String?>? onSaved;
  final FormFieldValidator<String>? validator;

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = kInputBorderRadius;
    const borderRadiusInsets = EdgeInsets.only(left: borderRadius);
    return FormField<String>(
      onSaved: widget.onSaved,
      validator: widget.validator,
      initialValue: widget.initialValue,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: borderRadiusInsets,
              child: Text(
                widget.label,
                style: AppTypography.bodyText.greyed(),
              ),
            ),
            CupertinoTextField(
              controller: _controller,
              onChanged: (value) {
                state.didChange(value);
              },
              expands: false,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              cursorColor: AppColors.grey,
            ),
            Padding(
              padding: borderRadiusInsets,
              child: Text(
                state.errorText ?? '',
                style: AppTypography.small.red(),
              ),
            )
          ],
        );
      },
    );
  }
}
