import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/styles.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    this.onTap,
    required this.label,
    this.disabled = false,
    this.isLoading = false,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String label;
  final bool disabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: disabled || isLoading ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isLoading)
              Text(
                label,
                style: AppTypography.h4,
              ),
            if (isLoading) const CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}
