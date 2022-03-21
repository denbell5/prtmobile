import 'package:flutter_test/flutter_test.dart';
import 'package:prtmobile/core/core.dart';

class _Item {
  final String id;
  final String value;

  _Item(
    this.id,
    this.value,
  );
}

void main() {
  test(
    'normalizes-collection',
    () {
      final collection = [_Item('id', 'value')];
      final normalized = NormalizedList.normalize<_Item, String>(
        collection,
        (item) => item.id,
      );
      expect(normalized.all.first, 'id');
      expect(normalized.byId['id'], collection.first);
    },
  );
}
