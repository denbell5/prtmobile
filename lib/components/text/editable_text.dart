import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/styles.dart';

class AppEditableText extends StatefulWidget {
  AppEditableText({
    Key? key,
    this.style,
    Color? decorationColor,
    Color? focusedDecorationColor,
    this.decorationHeight = kInputDecorationHeight,
    Color? cursorColor,
  })  : decorationColor = decorationColor ?? AppColors.lightGrey,
        focusedDecorationColor = focusedDecorationColor ?? AppColors.grey,
        cursorColor = cursorColor ?? AppColors.grey,
        super(key: key);

  final TextStyle? style;
  final Color decorationColor;
  final Color focusedDecorationColor;
  final double decorationHeight;
  final Color cursorColor;

  @override
  State<AppEditableText> createState() => _AppEditableTextState();
}

class _AppEditableTextState extends State<AppEditableText> {
  var isFocused = false;
  Color get activeDecorationColor =>
      isFocused ? widget.focusedDecorationColor : widget.decorationColor;

  late FocusNode focusNode;

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
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build ${buildCounter++}');
    return Column(
      children: [
        TextField(
          expands: false,
          decoration: null,
          cursorColor: widget.cursorColor,
          focusNode: focusNode,
          style: widget.style,
        ),
        HorizontalDivider(
          height: widget.decorationHeight,
          color: activeDecorationColor,
        ),
      ],
    );
  }
}
