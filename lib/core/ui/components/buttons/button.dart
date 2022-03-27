import 'package:flutter/cupertino.dart';
import 'package:prtmobile/core/core.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    this.onTap,
    this.label,
    this.disabled = false,
    this.isLoading = false,
    this.padding,
    this.child,
    this.bordered = true,
  })  : assert(label != null || child != null),
        super(key: key);

  final VoidCallback? onTap;
  final String? label;
  final bool disabled;
  final bool isLoading;
  final EdgeInsets? padding;
  final Widget? child;
  final bool bordered;

  Widget _buildContent(BuildContext context) {
    if (child != null) return child!;
    return Text(
      label!,
      style: AppTypography.h6,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled || isLoading ? null : onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kComponentBorderRadius),
          border: bordered ? Border.all(color: AppColors.black) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isLoading) _buildContent(context),
            if (isLoading) const CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}
