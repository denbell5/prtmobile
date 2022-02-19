import 'dart:async';
import 'dart:collection';

import 'package:flutter/widgets.dart';

class ListSelector<T> extends ChangeNotifier {
  bool _selectionEnabled = false;
  final Set<T> _selectedIds = {};

  bool get selectionModeEnabled => _selectionEnabled;
  Set<T> get selectedIds => UnmodifiableSetView(_selectedIds);

  void enableSelectionMode({T? itemId}) {
    _selectionEnabled = true;
    if (itemId != null) {
      _selectedIds.add(itemId);
    }
    notifyListeners();
  }

  void disableSelectionMode() {
    _selectionEnabled = false;
    _selectedIds.clear();
    notifyListeners();
  }

  void toggleSelectionMode({T? selectedId}) {
    if (_selectionEnabled) {
      disableSelectionMode();
    } else {
      enableSelectionMode(itemId: selectedId);
    }
  }

  void toggleItemSelection(T itemId) {
    if (_selectedIds.contains(itemId)) {
      _selectedIds.remove(itemId);
    } else {
      _selectedIds.add(itemId);
    }
    notifyListeners();
  }

  Future<void> deleteSelectedItems({
    FutureOr<bool> Function(Set<T> selectedIds)? confirmDeletion,
    required FutureOr<void> Function(Set<T> selectedIds) delete,
  }) async {
    final localSelectedIds = Set<T>.from(_selectedIds);
    final canDelete =
        confirmDeletion == null || await confirmDeletion(localSelectedIds);
    if (canDelete) {
      await delete(localSelectedIds);
      disableSelectionMode();
    }
  }
}
