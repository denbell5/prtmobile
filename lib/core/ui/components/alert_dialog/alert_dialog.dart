import 'package:flutter/cupertino.dart';
import 'package:prtmobile/core/core.dart';

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

class ConfirmDeletionDialog extends StatelessWidget {
  const ConfirmDeletionDialog({
    Key? key,
    required this.deletedCount,
    required this.entityName,
  }) : super(key: key);

  final int deletedCount;
  final String entityName;

  static Future<bool> askConfirmation(
    BuildContext context, {
    required ConfirmDeletionDialog dialog,
  }) async {
    final isConfirmed = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) {
        return dialog;
      },
    );
    return isConfirmed!;
  }

  @override
  Widget build(BuildContext context) {
    return YesNoDialog(
      title: Text(
        'Delete $deletedCount selected ${pluralize(entityName, count: deletedCount)}?',
        style: AppTypography.h5,
      ),
    );
  }
}
