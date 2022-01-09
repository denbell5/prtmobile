import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/styles.dart';

class TouchableX extends StatelessWidget {
  const TouchableX({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TouchableOpacity(
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Icon(
            CupertinoIcons.xmark,
            color: AppColors.grey,
            size: FontSizes.h3,
          ),
        ),
      ),
    );
  }
}
