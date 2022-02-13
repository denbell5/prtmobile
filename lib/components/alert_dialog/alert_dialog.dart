import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/buttons/buttons.dart';
import 'package:prtmobile/navigation/navigator.dart';
import 'package:prtmobile/styles/styles.dart';

class YesNoDialog extends StatelessWidget {
  const YesNoDialog({
    Key? key,
    required this.title,
  }) : super(key: key);

  final Widget title;

  Widget _buildAction(
    BuildContext context, {
    required bool value,
  }) {
    return TouchableWidget(
      onTap: () {
        AppNavigator.of(context).pop(value);
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding * 0.75,
          ),
          child: Text(
            value ? 'Yes' : 'No',
            style: AppTypography.h5,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(
            kDefaultPadding * 0.75,
          ),
        ),
        child: FractionallySizedBox(
          widthFactor: 0.75,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding).copyWith(
                  top: kDefaultPadding * 2,
                ),
                child: title,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildAction(
                      context,
                      value: true,
                    ),
                  ),
                  Expanded(
                    child: _buildAction(
                      context,
                      value: false,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
