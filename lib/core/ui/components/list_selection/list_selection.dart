import 'package:flutter/cupertino.dart';
import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/utils/utils.dart';

mixin ListItemSelectionMixin on State {
  bool selectionModeEnabled = false;
  final Set<String> selectedTracksetIds = {};

  void enableSelectionMode(
    String entityId, {
    bool Function()? canEnable,
  }) {
    if (selectionModeEnabled) return;
    if (canEnable?.call() == false) return;
    setState(() {
      selectedTracksetIds.add(entityId);
      selectionModeEnabled = true;
    });
  }

  void disableSelectionMode() {
    setState(() {
      selectedTracksetIds.clear();
      selectionModeEnabled = false;
    });
  }

  void toggleSelection(String tracksetId) {
    if (selectedTracksetIds.contains(tracksetId)) {
      setState(() {
        selectedTracksetIds.remove(tracksetId);
      });
    } else {
      setState(() {
        selectedTracksetIds.add(tracksetId);
      });
    }
  }

  void deleteSelectedItems({
    required String entityName,
    required void Function(Set<String> selectedIds) deleteAction,
  }) async {
    final selectedIds = Set<String>.from(selectedTracksetIds);
    if (selectedIds.isEmpty) return;

    bool canProceed = await showCupertinoDialog(
      context: context,
      builder: (context) {
        return YesNoDialog(
          title: Text(
            'Delete ${selectedIds.length} selected ${pluralize(entityName, count: selectedIds.length)}?',
            style: AppTypography.h5,
          ),
        );
      },
    );

    if (canProceed) {
      disableSelectionMode();
      deleteAction(selectedIds);
    }
  }
}
