import 'package:flutter/widgets.dart';
import 'package:prtmobile/core/core.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    Key? key,
    required this.description,
    this.onRetry,
  }) : super(key: key);

  final String description;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TouchableOpacity(
        onTap: onRetry,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding * 2,
          ),
          child: Text(
            '$description\nTap to retry',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
